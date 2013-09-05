class Suggest::ChannelsController < ApplicationController

#  before_filter :authenticate_user!

  def user
    # retrieve youtube's recommended videos for a user
    # and find the channels to which they belong

    url       = "https://gdata.youtube.com/feeds/api/users/default/recommendations?max-results=50&v=2&alt=json"
    response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )

    recs = response.parsed_response["feed"]["entry"].map do |entry|
      entry.dig("author", 0, "yt$userID", "$t")
    end
    
    render :json => recs
  end

  def channel
    # retrieve the most popular videos for the target channel
    # then retrieve the related videos for those and find the
    # channels to which they belong

    channel_id = params[:channel_id]
    limit      = (params[:limit] || 10).to_i

    top_videos = YoutubeApi.video_search_for_channel_id(channel_id, 10)

    related_videos = top_videos.collect do |video|
      YoutubeApi.related_videos_for_video_id( video[:video_id] )
    end
    related_videos.flatten!

    channel_videos = Hash.new(0)
    related_videos.each do |video|
      channel_videos[video[:channel_id]] += 1 unless video[:channel_id] == channel_id
    end

    channels = channel_videos.keys.sort { |a, b| channel_videos[a] <=> channel_videos[b] }

    render :json => channels.first(limit)
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

  def recently_watched
    # return the most recently-watched channels with positive ratings
  end

end
