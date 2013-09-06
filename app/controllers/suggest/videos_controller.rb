class Suggest::VideosController < ApplicationController

  respond_to :json

  before_filter :authenticate_user!, :except => [:related, :trending, :popular, :featured]


  ###################################################################################################
  # Requires current_user
  ###################################################################################################

  def suggested



  end


  def user
    url       = "https://gdata.youtube.com/feeds/api/users/default/recommendations?max-results=50&v=2&alt=json"
    recs      = Rails.cache.fetch( auto_cache_key(:user => current_user.id ), :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end

  end

  def recently_watched
    url       = "https://gdata.youtube.com/feeds/api/users/default/watch_history?v=2&alt=json&max-results=50"
    recs      = Rails.cache.fetch( auto_cache_key(:user => current_user.id ), :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, current_user.get_token )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end

  end

  def most_watched

    recs          = Rails.cache.fetch( auto_cache_key(:user => current_user.id ), :expires_in => 1.day ) do
      youtube_ids   = current_user.views.order("unique_view_count desc, weight desc").includes(:video).limit(50).all.collect{ |view| view.video.youtube_id }
      url           = "https://www.googleapis.com/youtube/v3/videos?part=id%2Csnippet%2CcontentDetails%2Cstatistics&id=#{youtube_ids.join(',')}"

      response      = YoutubeApi.v3_authorized_request( url, current_user.get_token )
      response.parsed_response["items"].map{ |entry| parse_v3_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end

  ###################################################################################################
  # Does not require current_user
  ###################################################################################################


  # params[:youtube_id]
  def related
    url       = "https://gdata.youtube.com/feeds/api/videos/#{params[:youtube_id]}/related?v=2&alt=json"
    recs      = Rails.cache.fetch( url , :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, nil )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end
    
    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end

  def trending
    url       = "https://gdata.youtube.com/feeds/api/standardfeeds/on_the_web"
    recs      = Rails.cache.fetch( url , :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, nil )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end


  def popular
    url       = "https://gdata.youtube.com/feeds/api/standardfeeds/most_popular"
    recs = Rails.cache.fetch( url, :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, nil )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end


  def featured
    url       = "https://gdata.youtube.com/feeds/api/standardfeeds/recently_featured"
    recs = Rails.cache.fetch( url, :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, nil )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end


  private

  def parse_v2_video_response(entry)
    {
      :id           => entry.dig("media$group", "yt$videoid", "$t"),
      :title        => entry.dig("title", "$t"),
      :channel_name => entry.dig("author", 0, "name", "$t"),
      :channel_guid => entry.dig("author", 0, "yt$userId", "$t"),
      :category     => entry.dig("media$group", "media$category", 0, "$t"),
      :statistics   => {
        :views    => entry.dig("yt$statistics", "viewCount"),
        :likes    => entry.dig("yt$rating", "numLikes"),
        :dislikes => entry.dig("yt$rating", "numDislikes"),
        :comments => entry.dig("gd$comments", "gd$feedLink", "countHint")
      }
    }
  end

  def parse_v3_video_response(entry)
    {
      :id           => entry.dig("id"),
      :title        => entry.dig("snippet", "title"),
      :channel_name => entry.dig("snippet", "channelTitle"),
      :channel_guid => entry.dig("snippet", "channelId"),
      :category     => Category.find_by_youtube_id( entry.dig("snippet", "categoryId") ).title,
      :statistics   => {
        :views    => entry.dig("statistics", "viewCount"),
        :likes    => entry.dig("statistics", "likeCount"),
        :dislikes => entry.dig("statistics", "dislikeCount"),
        :comments => entry.dig("statistics", "commentCount")
      }
    }
  end


end