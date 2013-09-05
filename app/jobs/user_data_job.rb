# API Listing of the things that will show up on your home page for an Auth'd user
# https://www.googleapis.com/youtube/v3/activities?part=id%2Csnippet%2CcontentDetails&home=true&key={YOUR_API_KEY}

# User reccomended Videos
# https://gdata.youtube.com/feeds/api/users/default/recommendations

# User reccomended Channels
# https://gdata.youtube.com/feeds/api/users/default/suggestion?type=channel&inline=true

# User watch History
# https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json

# User liked videos
# https://www.googleapis.com/youtube/v3/videos?part=id%2Csnippet%2CcontentDetails%2Cstatistics%2Cstatus&myRating=like&key={YOUR_API_KEY}

# User disliked videos
# https://www.googleapis.com/youtube/v3/videos?part=id%2Csnippet%2CcontentDetails%2Cstatistics%2Cstatus&myRating=dislike&key={YOUR_API_KEY}


class UserDataJob
  @queue = :medium

  def self.perform( user_id )
    u = User.find user_id
    return if u.nil?

    user_oauth_token = u.get_token # force a refresh if required and cache as local var


    build_watch_history( u, user_oauth_token )
    build_view_weights( u, user_oauth_token, "like", 1 )
    build_view_weights( u, user_oauth_token, "dislike", -1 )


  end

  def self.build_watch_history(u, user_oauth_token)

    url = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"

    while url.present? 
      response = YoutubeApi.v2_authorized_request( url, user_oauth_token )
      return if response.nil?

      new_views_this_page = false
      response.parsed_response["feed"]["entry"].each do |entry|
        video       = Video.where( youtube_id: entry.dig( "media$group", "yt$videoid", "$t" ) ).first_or_create

        unless video.category.present?
          cat = Category.find_by_title( entry.dig("category", 0, "label") )
          video.update_attributes( :category_id => cat.id ) if cat.present?
        end

        view        = View.where( video_id: video.id, user_id: u.id ).first_or_initialize
        unique_view = UniqueView.where( :youtube_id => entry["id"]["$t"] ).first_or_initialize

        if unique_view.new_record?
          new_views_this_page = true
          
          view.save

          unique_view.view_id = view.id
          unique_view.save
        end

      end

      return unless new_views_this_page

      url = nil
      response.parsed_response["feed"]["link"].each do |link|
        url = link["href"] if link["rel"] == "next"
      end
    end

  end


  def self.build_view_weights(u, user_oauth_token, endpoint, value)

    original_url  = "https://www.googleapis.com/youtube/v3/videos?part=id&myRating=#{endpoint}&maxResults=50"
    url           = original_url
    offset        = 0

    while url.present?
      result = YoutubeApi.v3_authorized_request( url, user_oauth_token )

      new_likes_this_page = false
      result.parsed_response["items"].each do |video|
        video = Video.where( youtube_id: video["id"] ).first_or_create
        view  = View.where( video_id: video.id, user_id: u.id ).first_or_create
        new_lkes_this_page = true if view.weight != value
        view.update_attributes( weight: value )
      end

      if result.parsed_response["nextPageToken"].present?
        url = original_url + "&pageToken=#{result.parsed_response['nextPageToken']}"
      else
        url = nil
      end

    end

  end





end