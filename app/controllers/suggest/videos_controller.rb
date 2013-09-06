class Suggest::VideosController < ApplicationController

  respond_to :json

  before_filter :authenticate_user!, :except => [:related, :trending, :popular, :featured]
  before_filter :load_category, :only => [:trending, :popular, :featured]


  ###################################################################################################
  # Requires current_user
  ###################################################################################################

  def suggested

    # Some naive secret sauce -- 10 videos that are that are the most frequently re-watched and liked; 10 that are the most frequently re-watched but not voted; 10 that are liked ordered by like time.
    ids = Set.new ( Video.where(:id => current_user.views.where(:weight => 1).order("unique_view_count desc, weight desc").select("video_id").limit(10).map(&:video_id) ).select("youtube_id").map(&:youtube_id) )
    ids.merge( Video.where( :id => current_user.views.where(:weight => 0).order("unique_view_count desc").select("video_id").limit(10).map(&:video_id) ).select("youtube_id").map(&:youtube_id ) )
    ids.merge( Video.where( :id => current_user.views.order("weight desc, updated_at desc").select("video_id").limit(10).map(&:video_id) ).select("youtube_id").map(&:youtube_id ) )

    recs = []
    ids.each do |youtube_id|
      url       = "https://gdata.youtube.com/feeds/api/videos/#{youtube_id}/related?v=2&alt=json"
      recs += Rails.cache.fetch( url , :expires_in => 1.day ){ YoutubeApi.v2_authorized_request( url, nil ).parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) } }
    end

    recs.sort!{|a,b| b[:statistics][:views].to_i <=> a[:statistics][:views].to_i }

    cat_count     = {}
    channel_count = {}
    recs_out      = []

    recs.each do |r|
      p r[:category], r[:channel]
      next if cat_count[ r[:category] ].present? && cat_count[ r[:category] ] >= 4
      next if channel_count[ r[:channel] ].present? && channel_count[ r[:channel] ] >= 2
      p [r[:category], cat_count[ r[:category] ].present?,  (cat_count[ r[:category] ] >= 4 if cat_count[ r[:category] ].present?) ]

      recs_out << r

      cat_count[ r[:category] ]     = 0 unless cat_count[ r[:category] ].present?
      channel_count[ r[:channel] ]  = 0 unless channel_count[ r[:channel] ].present?

      cat_count[ r[:category] ]     += 1
      channel_count[ r[:channel] ]  += 1

    end



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
      youtube_ids   = current_user.views.order("unique_view_count desc, weight desc").includes(:video).limit(50).collect{ |view| view.video.youtube_id }
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


  # Required = params[:youtube_id]
  def related
    render_404 and return unless params[:youtube_id].present?

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
    cat_name  = @category.present? ? "_#{@category.title}" : ""
    url       = "https://gdata.youtube.com/feeds/api/standardfeeds/on_the_web#{cat_name}"
    recs      = Rails.cache.fetch( url , :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, nil )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end


  def popular
    cat_name  = @category.present? ? "_#{@category.title}" : ""
    url       = "https://gdata.youtube.com/feeds/api/standardfeeds/most_popular#{cat_name}"
    recs = Rails.cache.fetch( url, :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, nil )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end


  def featured
    cat_name  = @category.present? ? "_#{@category.title}" : ""
    url       = "https://gdata.youtube.com/feeds/api/standardfeeds/recently_featured#{cat_name}"
    recs = Rails.cache.fetch( url, :expires_in => 1.day ) do
      response  = YoutubeApi.v2_authorized_request( url, nil )
      response.parsed_response["feed"]["entry"].map{ |entry| parse_v2_video_response( entry ) }
    end

    respond_to do |format|
      format.json { render :json => recs, :callback => params[:callback] }
    end
  end


  private

  def load_category
    @category = nil
    return unless params[:category].present?

    if is_a_number? params[:category]
      @category = Category.find params[:category].to_i
    else
      @category = Category.find_by_title params[:category]
    end
  end

  def parse_v2_video_response(entry)
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

  def parse_v3_video_response(entry)
    {
      :id           => entry.dig("id"),
      :title        => entry.dig("snippet", "title"),
      :channel_name => entry.dig("snippet", "channelTitle"),
      :channel_guid => entry.dig("snippet", "channelId"),
      :category     => Category.find_by_youtube_id( entry.dig("snippet", "categoryId") ).title,
      :statistics   => {
        :views    => entry.dig("statistics", "viewCount").to_i,
        :likes    => entry.dig("statistics", "likeCount").to_i,
        :dislikes => entry.dig("statistics", "dislikeCount").to_i,
        :comments => entry.dig("statistics", "commentCount").to_i
      }
    }
  end


end