module YoutubeApi

  V3_Url = "https://www.googleapis.com/youtube/v3"

  def self.uploads_playlist_id_for_channel(channel_id)
    url = V3_Url + "/channels"

    channel_url = V3_Url + "/channels"
    query = {
      key: $YOUTUBE_V3_API_KEY,
      id: channel_id,
      part: "contentDetails"
    }

    json = JSON.parse( HTTParty.get(channel_url, query: query).body )
    uploads_id = json['items'][0]['contentDetails']['relatedPlaylists']['uploads']

    uploads_id
  end

  def self.video_list_for_playlist(playlist_id, limit, page_token)
    playlist_url = V3_Url + "/playlistItems"
    query = {
      key: $YOUTUBE_V3_API_KEY,
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
    video_url = V3_Url + "/videos"
    query = {
      key: $YOUTUBE_V3_API_KEY,
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

  def self.video_list(channel_id, page, limit)
    playlist_id = uploads_playlist_id_for_channel(channel_id)
    video_list  = video_list_for_playlist(playlist_id, page, limit)

    video_data = video_list[:video_ids].collect do |video_id|
      video_data_for_video_id(video_id)
    end

    next_page_token = video_list[:next_page_token]

    { videos: video_data, next_page_token: next_page_token }
  end

end
