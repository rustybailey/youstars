module YoutubeApi

  @@V3_URL = "https://www.googleapis.com/youtube/v3"
  @@V2_URL = "https://gdata.youtube.com/feeds/api"

  def self.video_list(channel_id, limit, page_token = nil)
    playlist_id = uploads_playlist_id_for_channel(channel_id)
    video_list  = video_list_for_playlist(playlist_id, limit, page_token)
    video_data  = video_data_for_video_ids( video_list[:video_ids].join(',') )

    { videos: video_data, next_page_token: video_list[:next_page_token] }
  end

  def self.subscribe_current_user_to_channel(channel_id, oauth2_token)
    url   = "#{@@V3_URL}/subscriptions?part=snippet"
    
    headers = { }
    headers["X-GData-Key"]   = "key=#{ENV['YOUTUBE_API']}"
    headers["Content-Type"]  = "application/json"
    headers["Authorization"] = "Bearer #{oauth2_token}" if oauth2_token.present?
    
    body  = {
      snippet: {
        resourceId: {
          kind: 'youtube#channel',
          channelId: channel_id
        }
      }
    }

    JSON.parse( HTTParty.post( url, :headers => headers, :body => body.to_json ).body )
  end
  
  def self.search_videos_for_channel(channel_id, search_term)
    url = "#{@@V3_URL}/search"
    query = {
      part: 'id',
      channelId: channel_id,
      snippet: {
        title: search_term
      }
    }

    JSON.parse( HTTParty.get( url, :query => query ).body )
  end

  def self.uploads_playlist_id_for_channel(channel_id)
    url   = "#{@@V3_URL}/channels"
    query = {
      key:    ENV['YOUTUBE_API'],
      id:     channel_id,
      part:   'contentDetails',
      fields: 'items/contentDetails/relatedPlaylists/uploads'
    }

    json = JSON.parse( HTTParty.get(url, query: query).body )

    json.dig('items', 0, 'contentDetails', 'relatedPlaylists', 'uploads')
  end

  def self.video_list_for_playlist(playlist_id, limit, page_token = nil)
    url   = "#{@@V3_URL}/playlistItems"
    query = {
      key:        ENV['YOUTUBE_API'],
      playlistId: playlist_id,
      part:       'contentDetails',
      fields:     'nextPageToken,pageInfo,items/contentDetails/videoId',
      maxResults: limit,
      pageToken:  page_token
    }

    json = JSON.parse( HTTParty.get(url, query: query).body )    

    video_ids       = json['items'].collect { |i| i.dig('contentDetails', 'videoId') }
    next_page_token = json['nextPageToken']

    { video_ids: video_ids, next_page_token: next_page_token }
  end
  
  def self.video_data_for_video_ids(video_ids)
    url   = "#{@@V3_URL}/videos"
    query = {
      key:    ENV['YOUTUBE_API'],
      id:     video_ids,
      part:   'snippet,statistics,topicDetails'
      #fields: 'items(id,snippet(title,thumbnails,tags),statistics/viewCount,topicDetails/topicIds)'
    }

    json = JSON.parse( HTTParty.get(url, query: query).body )    
    data = []

    json['items'].each do |item|
      data << {
        video_id:     item['id'],
        title:        item.dig('snippet', 'title'),
        published_at: item.dig('snippet', 'publishedAt'),
        thumbnails:   item.dig('snippet', 'thumbnails'),
        topics:       item.dig('topicDetails', 'topicIds'),
        view_count:   item.dig('statistics', 'viewCount').to_i
      }
    end

    data
  end

  def self.channel_data_for_channel_id(channel_id)
    if channel_id.is_a? Array
      channel_id = channel_id.join(',')
    end

    v3_channel_url = @@V3_URL + "/channels"
    v3_query = {
      key: ENV['YOUTUBE_API'],
      id: channel_id,
      part: 'snippet,statistics'
    }

    json = JSON.parse( HTTParty.get(v3_channel_url, query: v3_query).body )    
    
    output = json['items'].collect do |item|
      {      
        channel_id:       item['id'],
        published_at:     item['snippet']['publishedAt'],      
        thumbnails:       item['snippet']['thumbnails'],
        title:            item['snippet']['title'],
        description:      item['snippet']['description'],
        view_count:       item['statistics']['viewCount'].to_i,
        subscriber_count: item['statistics']['subscriberCount'].to_i
      }
    end

    output.each_index do |i|
      v2_channel_url = "https://gdata.youtube.com/feeds/api/users/#{ output[i][:channel_id] }"
      v2_query = {
        v: 2,
        alt: 'json'
      }
    
      output[i][:name] = JSON.parse( HTTParty.get(v2_channel_url, query: v2_query).body ).dig('entry', 'yt$username', '$t')
    end
    
    output
  end

  def self.channel_id_for_username(channel_username)
    p channel_username
    channel_url = "https://gdata.youtube.com/feeds/api/users/" + channel_username
    query = {
      v: 2,
      alt: 'json'
    }

    json = JSON.parse( HTTParty.get(channel_url, query: query).body )

    'UC' + json.dig('entry', 'author', 0, 'yt$userId', '$t')
  end

  def self.channel_stats_for_channel_id(channel_id)
    channel_url = @@V3_URL + '/channels'
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


  def self.related_videos_for_video_id(video_id, limit = 50)
    search_url = @@V3_URL + '/search'
    query = {
      key: ENV['YOUTUBE_API'],
      relatedToVideoId: video_id,
      maxResults: limit,
      part:  'snippet',
      type:  'video'
    }
    
    json = JSON.parse( HTTParty.get(search_url, query: query).body )    

    json['items'].collect do |item|
      {
        video_id:   item['id']['videoId'],
        title: item['snippet']['title'],
        channel_id: item['snippet']['channelId']
      }
    end
  end

  def self.video_search_for_channel_id(channel_id, limit = 50, order = 'viewCount')
    search_url = @@V3_URL + '/search'
    query = {
      key: ENV['YOUTUBE_API'],
      channelId: channel_id,
      maxResults: limit,
      part: 'snippet',
      type: 'video',
      order: order
    }

    json = JSON.parse( HTTParty.get(search_url, query: query).body )

    json['items'].collect do |item|
      {
        video_id: item['id']['videoId'],
        title: item['snippet']['title'],
        channel_id: item['snippet']['channelId']
      }
    end
  end
  
  def self.v2_authorized_request( url, oauth2_token, params = {} )
    v3_authorized_request( url, oauth2_token, {"v" => 2, "alt" => "json"} )
  end

  def self.v3_authorized_request( url, oauth2_token, params = {})
    headers = { "X-GData-Key" => "key=#{ENV['YOUTUBE_API']}" }
    headers["Authorization"] = "Bearer #{oauth2_token}" if oauth2_token.present?
    HTTParty.get( url, :query => params, :headers => headers )
  end

end
