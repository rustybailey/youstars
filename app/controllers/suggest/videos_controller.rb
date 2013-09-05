class Suggest::VideosController < ApplicationController

  before_filter :authenticate_user!

  def user
    url       = "https://gdata.youtube.com/feeds/api/users/default/recommendations?max-results=50&v=2&alt=json"
    response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )


    recs = response.parsed_response["feed"]["entry"].map do |entry|
      video_id = entry.dig("media$group", "yt$videoid", "$t")

      {
        :id           => video_id,
        :title        => entry.dig("title", "$t"),
        :channel_name => entry.dig("author", 0, "name", "$t"),
        :channel_guid => entry.dig("author", 0, "yt$userId", "$t"),
        :category     => entry.dig("media$group", "media$category", 0, "$t"),
        :statistics   => {
          :views    => entry.dig("yt$statistics", "viewCount"),
          :likes    => entry.dig("yt$rating", "numLikes"),
          :dislikes => entry.dig("yt$rating", "numDislikes"),
          :rating   => entry.dig("gd$rating", "average"),
        }
      }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end

  end

  def recently_watched
    url       = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
    response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )

    recs = response.parsed_response["feed"]["entry"].map do |entry|
      video_id = entry.dig("media$group", "yt$videoid", "$t")

      {
        :id           => video_id,
        :title        => entry.dig("title", "$t"),
        :channel_name => entry.dig("author", 0, "name", "$t"),
        :channel_guid => entry.dig("author", 0, "yt$userId", "$t"),
        :category     => entry.dig("media$group", "media$category", 0, "$t"),
        :statistics   => {
          :views    => entry.dig("yt$statistics", "viewCount"),
          :likes    => entry.dig("yt$rating", "numLikes"),
          :dislikes => entry.dig("yt$rating", "numDislikes"),
          :rating   => entry.dig("gd$rating", "average"),
        }
      }
    end

  end


end