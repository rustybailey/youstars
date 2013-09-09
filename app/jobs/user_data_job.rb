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

    return if user_oauth_token.nil?

    build_watch_history( u, user_oauth_token )
    build_view_weights( u, user_oauth_token, "like", 1 )
    build_view_weights( u, user_oauth_token, "dislike", -1 )
    build_suggestions_list(u)


  end

  def self.build_suggestions_list(u)

    # Some naive secret sauce -- 
    #   10 videos that are that are the most frequently re-watched and liked; 
    #   10 that are the most frequently re-watched but not voted; 
    #   10 that are liked ordered by like time.
    # Then we get reccomended videos for all of them, remove viewed videos, sort on views, and enforce variety.

    ids = Set.new ( Video.where(:id => u.views.where(:weight => 1).order("unique_view_count desc, weight desc").select("video_id").limit(10).map(&:video_id) ).select("youtube_id").map(&:youtube_id) )
    ids.merge( Video.where( :id => u.views.where(:weight => 0).order("unique_view_count desc").select("video_id").limit(10).map(&:video_id) ).select("youtube_id").map(&:youtube_id ) )
    ids.merge( Video.where( :id => u.views.order("weight desc, updated_at desc").select("video_id").limit(10).map(&:video_id) ).select("youtube_id").map(&:youtube_id ) )

    recs = []
    ids.each do |youtube_id|
      url       = "https://gdata.youtube.com/feeds/api/videos/#{youtube_id}/related?v=2&alt=json"
      recs += Rails.cache.fetch( url , :expires_in => 1.day ) do 
        ret = nil
        begin
          ret = YoutubeApi.v2_authorized_request( url, nil ).parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
        rescue
          ret = []
        end
        ret 
      end
    end

    recs = recs.uniq.reject{ |v| Bragi.test_video(u, v[:id]) }

    recs.sort!{|a,b| b[:statistics][:views].to_i <=> a[:statistics][:views].to_i }

    cat_count     = {}
    channel_count = {}
    recs_out      = []

    recs.each do |r|
      next if cat_count[ r[:category] ].present? && cat_count[ r[:category] ] >= 4
      next if channel_count[ r[:channel_name] ].present? && channel_count[ r[:channel_name] ] >= 2

      p [r[:category], cat_count[ r[:category] ].present?,  (cat_count[ r[:category] ] >= 4 if cat_count[ r[:category] ].present?) ]

      recs_out << r

      cat_count[ r[:category] ]         = 0 unless cat_count[ r[:category] ].present?
      cat_count[ r[:category] ]         += 1

      channel_count[ r[:channel_name] ] = 0 unless channel_count[ r[:channel_name] ].present?
      channel_count[ r[:channel_name] ] += 1

    end

    u.update_attributes(
      :custom_suggestions => recs_out.to_json
    )


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


  def self.parse_v2_video_response(entry)
    {
      :id           => entry.dig("media$group", "yt$videoid", "$t"),
      :title        => entry.dig("title", "$t"),
      :channel_name => entry.dig("author", 0, "name", "$t"),
      :channel_guid => entry.dig("author", 0, "yt$userId", "$t"),
      :category     => entry.dig("media$group", "media$category", 0, "$t"),
      :statistics   => {
        :views    => entry.dig("yt$statistics", "viewCount").to_i,
        :likes    => entry.dig("yt$rating", "numLikes").to_i,
        :dislikes => entry.dig("yt$rating", "numDislikes").to_i,
        :comments => entry.dig("gd$comments", "gd$feedLink", "countHint").to_i
      }
    }
  end




end