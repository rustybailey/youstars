require 'youtube_api'

class ChannelController < ApiController

  before_filter :load_channel_id, :except => [:search]

  def create
    return if current_user.nil?
    return unless current_user.guid == @channel_id

    channel = Channel.new do |c|
      c.youtube_id  = @channel_id
      c.name        = params[:name]
      c.gender      = params[:gender]
      c.location    = params[:location]
      c.description = params[:description]
    end

    c.save
    Resque.enqueue_in_with_queue(:immediate, 0, ChannelDataJob, @channel_id)

    render :json => c.attributes
  end

  def update
    return if current_user.nil?
    return unless current_user.guid == @channel_id

    c = Channel.find_by_youtube_id( @channel_id )
    
    [:youtube_id, :name, :gender, :location, :description].each do |attribute|   
      c.update_attribute(attribute, params[attribute]) if params[attribute].present?
    end

    c.save

    render :json => c.attributes
  end

  def show
    youtube_ids = @channel_id.split(',')

    output = youtube_ids.collect do |youtube_id|
      Channel.find_by_youtube_id(youtube_id).attributes
    end

    render :json => output
  end

  def videos
    page_token = params[:page_token]
    limit      = params[:limit] || 20

    # increasing expiration for the demo
    list = Rails.cache.fetch( auto_cache_key(params), :expires_in => 3.days ) do

      list = YoutubeApi.video_list(@channel_id, limit, page_token)

    end

    render :json => list
  end
  
  def topics
    topics = { 
      youtube_id: @channel_id,
      topics: Channel.find_by_youtube_id(@channel_id).topics.map(&:name)
    }    

    render :json => topics
  end

  def search_within_channel
    search_term = params[:search_term]

    url = 'https://www.googleapis.com/youtube/v3/search'

    token = current_user.get_token if current_user.present?

    query = {
      key: ENV['YOUTUBE_API'],
      part: 'id,snippet',
      channelId: @channel_id,
      q: search_term
    }
    query = query.merge( { pageToken: params[:page_token] } ) if params[:page_token].present?

    response = YoutubeApi.v3_authorized_request( url, token, query )

    render :json => JSON.parse( response.body )
  end

  def search
    search_term = params[:search_term]

    url = 'https://www.googleapis.com/youtube/v3/search'

    token = current_user.get_token if current_user.present?

    query = { 
      key: ENV['YOUTUBE_API'],
      part: 'id,snippet',
      q: search_term
    }
    query = query.merge( { pageToken: params[:page_token] } ) if params[:page_token].present?

    response = YoutubeApi.v3_authorized_request( url, token, query )

    render :json => JSON.parse( response.body )
  end

  def subscribe
    authenticate_user!

    response = YoutubeApi.subscribe_current_user_to_channel(@channel_id, current_user.get_token)

    render :json => response
  end

  def stream
    redis = Resque.redis

    subs_series   = JSON.parse( redis.get( "#{@channel_id}_subs_series" ) || '[]' )
    subs_series ||= []

    if subs_series.length < 3 or Time.now.to_i > (subs_series.last['timestamp'] + 60.minutes.to_i)
      new_stats = YoutubeApi.channel_stats_for_channel_id(@channel_id)

      subs_series << { timestamp: Time.now.to_i }.merge( new_stats )
      subs_series  = subs_series.last(3)

      redis.set( "#{@channel_id}_subs_series", subs_series.to_json )
    end


    views_series   = JSON.parse( redis.get( "#{@channel_id}_views_series" ) || '[]' )
    views_series ||= []

    if views_series.length < 3 or Time.now.to_i > (views_series.last['timestamp'] + 60.minutes.to_i)
      new_stats = YoutubeApi.channel_stats_for_channel_id(@channel_id) if new_stats.nil?

      views_series << { timestamp: Time.now.to_i }.merge( new_stats )
      views_series  = views_series.last(3)

      redis.set( "#{@channel_id}_views_series", views_series.to_json )
    end


    if subs_series.length < 3 or views_series.length < 3
      render( :json => { view_count: views_series.last[:view_count], subscriber_count: subs_series.last[:subscriber_count] } ) and return 
    end


    views_series = JSON.parse( redis.get( "#{@channel_id}_views_series" ) )
    subs_series  = JSON.parse( redis.get( "#{@channel_id}_subs_series"  ) )

    views_delta_t0 = views_series.last['timestamp'] - views_series.first['timestamp']
    subs_delta_t0  = subs_series.last['timestamp']  - subs_series.first['timestamp']

    views_delta_t1 = Time.now.to_i - views_series.last['timestamp']    
    subs_delta_t1  = Time.now.to_i - subs_series.last['timestamp']    

    moving_averages = {
      'view_count'       => (views_series.last['view_count']      - views_series.first['view_count'])      / views_delta_t0.to_f,
      'subscriber_count' => (subs_series.last['subscriber_count'] - subs_series.first['subscriber_count']) / subs_delta_t0.to_f
    }

    estimates = {
      'view_count'       => views_series.last['view_count']       + (moving_averages['view_count']       * views_delta_t1).to_i,
      'subscriber_count' => subs_series.last['subscriber_count']  + (moving_averages['subscriber_count'] * subs_delta_t1).to_i
    }

    render :json => estimates
  end

  
  
end

