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
    recs = Rails.cache.fetch( auto_cache_key( user: current_user.guid ), :expires_in => 1.day ) do

      url      = "https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_viewed?v=2&alt=json"
      response = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    
      recs = response.parsed_response["feed"]["entry"].map do |entry|
        'UC' + entry.dig("author", 0, "yt$userID", "$t")
      end
    
      recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r ) }.collect do |id|
        YoutubeApi.channel_data_for_channel_id(id)
      end

    end

    recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r[:channel_id] ) }

    render :json => recs
  end

  def most_subscribed
    recs = Rails.cache.fetch( auto_cache_key( user: current_user.guid ), :expires_in => 1.day ) do

      url      = "https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_subscribed?v=2&alt=json"
      response = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    
      recs = response.parsed_response["feed"]["entry"].map do |entry|
        'UC' + entry.dig("author", 0, "yt$userID", "$t")
      end

      recs = recs.reject { |r| Bragi.test_channel(current_user.guid, r) }
      recs = YoutubeApi.channel_data_for_channel_id(recs)

    end

    recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r[:channel_id] ) }
    
    render :json => recs
  end

  def user
    # retrieve youtube's recommended videos for a user
    # and find the channels to which they belong

    recs = Rails.cache.fetch( auto_cache_key( {:user => current_user.guid} ), :expires_in => 1.day ) do
    
      url       = "https://gdata.youtube.com/feeds/api/users/default/recommendations?max-results=50&v=2&alt=json"
      response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )

      recs = response.parsed_response["feed"]["entry"].map do |entry|nice
        'UC' + entry.dig("author", 0, "yt$userId", "$t")
      end
    
      recs = recs.reject { |r| Bragi.test_channel(current_user.guid, r) }
      recs = YoutubeApi.channel_data_for_channel_id(recs)

    end
    
    recs = recs.reject { |r| Bragi.test_channel( current_user.guid, r[:channel_id] ) }
    
    render :json => recs
  end

  def similar_to_your_channel
    recs = Rails.cache.fetch( auto_cache_key( user: current_user.guid ), :expires_in => 1.day ) do

      channel_id = current_user.channel.youtube_id

      channels       = Pythia.related(channel_id, 15)
      cheap_channels = Pythia.cheap_related(channel_id, 45)

      recs = [topical_channels, cheap_channels].flatten.uniq { |c| c[:channel_id] }

    end

    render :json => recs
  end

  def recently_watched
    url        = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
    response   = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    video_recs = response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id   =>        entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => 'UC' + entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    next_url    = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50&page=2"
    response    = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    video_recs << response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id   =>        entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => 'UC' + entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    video_recs = video_recs.reject do |e|
      e[:video_id].in?( current_user.channel.disliked_videos.map(&:id) )
    end

    channel_recs = YoutubeApi.channel_data_for_channel_id( video_recs.collect { |v| v[:channel_id] }

    render :json => channel_recs
  end

  def similar_to_recently_watched
    url        = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
    response   = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos = response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id   =>        entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => 'UC' + entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    next_url    = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50&page=2"
    response    = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos << response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id   =>        entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => 'UC' + entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    videos = videos.reject do |e|
      e[:video_id].in?( current_user.channel.disliked_videos.map(&:id) )
    end

    channels =  YoutubeApi.channel_data_for_channel_id( videos.collect { |v| v[:channel_id]  } )

    channel_recs = []
    channels.first(5).each do |c|
      channel_recs << Pythia.related(c[:channel_id]).first(4)
    end
    channel_recs.flatten!

    render :json => channel_recs
  end

  def similar_to_recently_liked
    url        = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
    response   = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos = response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id   =>        entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => 'UC' + entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    next_url    = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50&page=2"
    response    = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos << response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id   =>        entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => 'UC' + entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    videos = videos.select do |e|
      e[:video_id].in?( current_user.channel.liked_videos.map(&:id) )
    end

    channels =  YoutubeApi.channel_data_for_channel_id( videos.collect { |v| v[:channel_id]  } )

    channel_recs = []
    channels.first(5).each do |c|
      channel_recs << Pythia.related(c[:channel_id]).first(4)
    end
    channel_recs.flatten!

    render :json => channel_recs
  end

  def topics
    # return the top channels when sorted by topic overlap
    # tf-idf relevance
  end

  def ratings
    # return the top channels sorted by ratings given by similar users
    # define similarity with distance metric on vector space of ratings
    # and/or tf-idf relevance of positively-rated channels
  end

end
