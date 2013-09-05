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


class WatchHistoryJob
  @queue = :medium

  def self.perform( user_id )
    u = User.find user_id
    return if u.nil?

    user_oauth_token = u.get_token # force a refresh if required and cache as local var
    build_watch_history( u, user_oauth_token )

  end

  def self.build_watch_history(u, user_oauth_token)

    url = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"

    while url.present? 
      p url
      response = v2_authorized_request( url, user_oauth_token )
      return if response.nil?

      new_views_this_page = false
      response.parsed_response["feed"]["entry"].each do |entry|
        video = Video.where( youtube_id: entry["media$group"]["yt$videoid"]["$t"] ).first_or_create
        view = View.where( video_id: video.id, user_id: u.id ).first_or_initialize
        if view.new_record?
          new_views_this_page = true
          view.save
        end
      end

      return unless new_views_this_page

      url = nil
      response.parsed_response["feed"]["link"].each do |link|
        url = link["href"] if link["rel"] == "next"
      end
    end

  end

  def self.v2_authorized_request( url, oauth2_token, params = {} )
    v3_authorized_request( url, oauth2_token, {"v" => 2, "alt" => "json"} )
  end

  def self.v3_authorized_request( url, oauth2_token, params = {})
    HTTParty.get( url, :query => params, :headers => {"Authorization" =>  "Bearer #{oauth2_token}", "X-GData-Key" => "key=#{$YOUTUBE_API}"} )
  end




end