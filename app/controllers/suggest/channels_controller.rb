class Suggest::ChannelsController < ApiController

  before_filter :authenticate_user!, :except => [:related, :most_viewed, :most_subscribed]

  def related
    # retrieve the most popular videos for the target channel
    # then retrieve the related videos for those and find the
    # channels to which they belong
    load_channel_id
    
    limit      = (params[:limit] || 20).to_i
    channels = Pythia.related(@channel_id).first(limit)
    
    render :json => channels
  end

  def most_viewed
    url      = "https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_viewed?v=2&alt=json"
    response = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    
    recs = response.parsed_response["feed"]["entry"].map do |entry|
      entry.dig("author", 0, "yt$userID", "$t")
    end
    
    recs = recs.collect do |id|
      YoutubeApi.channel_data_for_channel_id(id)
    end

    render :json => recs
  end

  def most_subscribed
    url      = "https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_subscribed?v=2&alt=json"
    response = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    
    recs = response.parsed_response["feed"]["entry"].map do |entry|
      entry.dig("author", 0, "yt$userID", "$t")
    end
    
    recs = recs.collect do |id|
      YoutubeApi.channel_data_for_channel_id(id)
    end

    render :json => recs
  end

  def user
    # retrieve youtube's recommended videos for a user
    # and find the channels to which they belong

    url       = "https://gdata.youtube.com/feeds/api/users/default/recommendations?max-results=50&v=2&alt=json"
    response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )

    recs = response.parsed_response["feed"]["entry"].map do |entry|
      entry.dig("author", 0, "yt$userID", "$t")
    end
    
    recs = recs.collect do |id|
      YoutubeApi.channel_data_for_channel_id(id)
    end

    render :json => recs
  end

  def recently_watched
    url        = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
    response   = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    video_recs = response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id => entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    next_url    = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50&page=2"
    response    = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    video_recs << response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id => entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    video_recs = video_recs.reject do |e|
      e[:video_id].in?( current_user.channel.disliked_videos.map(&:id) )
    end

    channel_recs = video_recs.collect do |e|
      YoutubeApi.channel_data_for_channel_id( e[:channel_id] )
    end

    render :json => channel_recs
  end

  def similar_to_recently_watched
    url        = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
    response   = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos = response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id => entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    next_url    = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50&page=2"
    response    = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos << response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id => entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    videos = videos.reject do |e|
      e[:video_id].in?( current_user.channel.disliked_videos.map(&:id) )
    end

    channels = videos.collect do |e|
      YoutubeApi.channel_data_for_channel_id( e[:channel_id] )
    end

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
        :video_id => entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    next_url    = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50&page=2"
    response    = YoutubeApi.v2_authorized_request( url, current_user.get_token )
    videos << response.parsed_response["feed"]["entry"].map do |entry| 
      { 
        :video_id => entry.dig("media$group", "yt$videoid", "$t"),
        :channel_id => entry.dig("author", 0, "yt$userId", "$t")
      }
    end

    videos = videos.select do |e|
      e[:video_id].in?( current_user.channel.liked_videos.map(&:id) )
    end

    channels = videos.collect do |e|
      YoutubeApi.channel_data_for_channel_id( e[:channel_id] )
    end

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
