module YoutubeApi

  @@v3_URL = "https://www.googleapis.com/youtube/v3"

  def self.video_list(channel_id, page, limit)
    playlist_id = uploads_playlist_id_for_channel(channel_id)
    video_list  = video_list_for_playlist(playlist_id, page, limit)

    video_data = video_list[:video_ids].collect do |video_id|
      video_data_for_video_id(video_id)
    end

    next_page_token = video_list[:next_page_token]

    { videos: video_data, next_page_token: next_page_token }
  end

  def self.uploads_playlist_id_for_channel(channel_id)
    url = @@v3_URL + "/channels"

    channel_url = @@v3_URL + "/channels"
    query = {
      key: ENV['YOUTUBE_API'],
      id: channel_id,
      part: "contentDetails"
    }

    json = JSON.parse( HTTParty.get(channel_url, query: query).body )
    uploads_id = json['items'][0]['contentDetails']['relatedPlaylists']['uploads']

    uploads_id
  end

  def self.video_list_for_playlist(playlist_id, limit, page_token)
    playlist_url = @@v3_URL + "/playlistItems"
    query = {
      key: ENV['YOUTUBE_API'],
      playlistId: playlist_id,
      part: "contentDetails",
      maxResults: limit,
      pageToken: page_token
    }

    json = JSON.parse( HTTParty.get(playlist_url, query: query).body )    
    video_ids = json['items'].collect { |i| i['contentDetails']['videoId'] }
    next_page_token =  json['nextPageToken']

    { video_ids: video_ids, next_page_token: next_page_token }
  end
  
  def self.video_data_for_video_id(video_id)
    video_url = @@v3_URL + "/videos"
    query = {
      key: ENV['YOUTUBE_API'],
      id: video_id,
      part: "snippet,statistics"
    }

    json = JSON.parse( HTTParty.get(video_url, query: query).body )    

    {
      published_at: json['items'][0]['snippet']['publishedAt'],
      thumbnails: json['items'][0]['snippet']['thumbnails'],
      title: json['items'][0]['snippet']['title'],
      view_count: json['items'][0]['statistics']['viewCount'].to_i
    }
  end

  def self.channel_stats_for_channel_id(channel_id)
    channel_url = @@v3_URL + '/channels'
    query = {
      key:  ENV['YOUTUBE_API'],
      id:   channel_id,
      part: 'statistics'
    }

    json = JSON.parse( HTTParty.get(channel_url, query: query).body )

    {
      view_count:       json['items'][0]['statistics']['viewCount'].to_i,
      subscriber_count: json['items'][0]['statistics']['subscriberCount'].to_i
    }
  end

end
