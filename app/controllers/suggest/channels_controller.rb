class Suggest::ChannelsController < ApiController

  before_filter :authenticate_user!, :except => [:related, :most_viewed, :most_subscribed]

  def related
    # retrieve the most popular videos for the target channel
    # then retrieve the related videos for those and find the
    # channels to which they belong
    load_channel_id    

    recs = Rails.cache.fetch( auto_cache_key( channel: @channel_id ), :expires_in => 1.day ) do

      topical_channels = Pythia.related(@channel_id, 15, 0.2)
      cheap_channels   = Pythia.cheap_related(@channel_id, 45)
      
      recs = [topical_channels, cheap_channels].flatten.uniq { |c| c[:channel_id] }
      
    end
    
    render :json => recs
  end
  
  def most_viewed
    params = {}
    params[:user] = current_user.id if current_user.present?

    recs = Rails.cache.fetch( auto_cache_key(params), :expires_in => 1.day ) do

      url      = "https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_viewed?v=2&alt=json"
      response = YoutubeApi.v2_authorized_request( url, '' )
    
      recs = response.parsed_response["feed"]["entry"].map do |entry|
        entry.dig( "yt$channelId", "$t" )
      end
    
      recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r ) } unless current_user.nil?
      recs = YoutubeApi.channel_data_for_channel_id(recs)

    end

    recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r[:channel_id] ) } unless current_user.nil?

    render :json => recs
  end

  def most_subscribed
    params = {}
    params[:user] = current_user.id if current_user.present?

    recs = Rails.cache.fetch( auto_cache_key(params), :expires_in => 1.day ) do

      url      = "https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_subscribed?v=2&alt=json"
      response = YoutubeApi.v2_authorized_request( url, '' )    

      recs = response.parsed_response["feed"]["entry"].map do |entry|
        entry.dig( "yt$channelId", "$t" )
      end

      recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r) } unless current_user.nil?
      recs = YoutubeApi.channel_data_for_channel_id(recs)

    end

    recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r[:channel_id] ) } unless current_user.nil?
    
    render :json => recs
  end

  def user
    # retrieve youtube's recommended videos for a user
    # and find the channels to which they belong

    recs = Rails.cache.fetch( auto_cache_key( {:user => current_user.guid} ), :expires_in => 1.day ) do
    
      url       = "https://gdata.youtube.com/feeds/api/users/default/recommendations?max-results=50&v=2&alt=json"
      response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )

      recs = response.parsed_response["feed"]["entry"].map do |entry|
        entry.dig("media$group", "yt$uploaderId", "$t")
      end
    
      recs = recs.reject { |r| Bragi.test_channel(current_user.guid, r) }
      recs = YoutubeApi.channel_data_for_channel_id(recs)

    end
    
    recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r[:channel_id] ) }
    
    render :json => recs
  end

  def similar_to_your_channel
    recs = Rails.cache.fetch( auto_cache_key( user: current_user.guid ), :expires_in => 1.day ) do

      topical_channels = Pythia.related(current_user.guid, 15, 0.2)
      cheap_channels   = Pythia.cheap_related(current_user.guid, 45)
      
      recs = [topical_channels, cheap_channels].flatten.uniq { |c| c[:channel_id] }
      
    end
    
    render :json => recs
  end

  def recently_watched
    channel_recs = Rails.cache.fetch( auto_cache_key( user: current_user.guid ), :expires_in => 1.day ) do

      url        = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
      response   = YoutubeApi.v2_authorized_request( url, current_user.get_token )
      channel_ids = response.parsed_response["feed"]["entry"].map do |entry| 
        entry.dig("media$group", "yt$uploaderId", "$t")
      end
      
      channel_ids.uniq!
      
      channel_recs = YoutubeApi.channel_data_for_channel_id( channel_ids )

    end

    render :json => channel_recs
  end

  def similar_to_recently_watched
    channel_recs = Rails.cache.fetch( auto_cache_key( user: current_user.guid ), :expires_in => 1.day ) do

      url        = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
      response   = YoutubeApi.v2_authorized_request( url, current_user.get_token )
      channel_ids = response.parsed_response["feed"]["entry"].map do |entry| 
        entry.dig("media$group", "yt$uploaderId", "$t")
      end
    
      channel_ids.flatten.uniq!
      
      channel_recs = []
      channel_ids.first(5).each do |c_id|
        channel_recs << Pythia.related(c_id).first(4)
      end
      channel_recs = channel_recs.flatten.uniq

    end
      
    render :json => channel_recs
  end

  # NOT YET WORKING
  def trending_by_topic
    # returns a list of channels with currently trending videos, ranked by topical relevance to the user's channel
    # tf-idf relevance

    url       = 'https://gdata.youtube.com/feeds/api/standardfeeds/most_shared?v=2&alt=json&max-results=50'
    response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos    = response.parsed_response['feed']['entry'].map do |entry|
      {
        :video_id   => entry.dig('media$group', 'yt$videoid', '$t'),
        :channel_id => entry.dig('media$group', 'yt$uploaderId', '$t')
      }
    end

    url       = "#{url}&page=2"
    response  = YoutubeApi.v2_authorized_request( next_url, current_user.get_token )
    videos   << response.parsed_response['feed']['entry'].map do |entry|
      {
        :video_id   => entry.dig('media$group', 'yt$videoid', '$t'),
        :channel_id => entry.dig('media$group', 'yt$uploaderId', '$t')
      }
    end

    videos = videos.reject do |entry|
      entry[:video_id].in?( current_user.disliked_videos.map(&:id) )
    end

    videos = videos.order_by do |entry|
    end
 
    channels = videos.map do |entry|
      YoutubeApi.channel_data_for_channel_id( entry[:channel_id] )
    end

    render :json => channels
  end

end
