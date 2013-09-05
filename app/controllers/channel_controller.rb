require 'youtube_api'

class ChannelController < ApplicationController

  def create
    channel = Channel.new do |c|
      c.youtube_id  = params[:youtube_id]
      c.name        = params[:name]
      c.gender      = params[:gender]
      c.location    = params[:location]
      c.description = params[:description]
    end

    c.save

    render :json => c.attributes
  end

  def update
    c = Channel.find_by_youtube_id( params[:youtube_id] )
    
    [:youtube_id, :name, :gender, :location, :description].each do |attribute|   
      c.update_attribute(attribute, params[attribute]) if params[attribute].present?
    end

    c.save

    render :json => c.attributes
  end

  def show
    youtube_ids = params[:youtube_id].split(',')

    output = youtube_ids.collect do |youtube_id|
      Channel.find_by_youtube_id(youtube_id).attributes
    end

    render :json => output
  end

  def videos
    youtube_id = params[:youtube_id]
    page_token = params[:page_token]
    limit      = params[:limit] || 20

    video_list = YoutubeApi.video_list(youtube_id, limit, page_token)

    render :json => video_list
  end

  def topics
    youtube_ids = params[:youtube_id].split(',')

    topics = youtube_ids.collect do |youtube_id|
      { 
        youtube_id: youtube_id,
        topics: Channel.find_by_youtube_id(youtube_id).topics.map(&:name)
      }
    end

    render :json => topics
  end

  def stream
    youtube_id = params[:youtube_id]

    redis = Redis.connect

    stats_series   = JSON.parse( redis.get( "#{youtube_id}_stats_series" ) || '[]' )
    stats_series ||= []

    if stats_series.length < 3 or Time.now.to_i > (stats_series.last['timestamp'] + 10.minutes.to_i)
      new_stats = YoutubeApi.channel_stats_for_channel_id(youtube_id)
      stats_series << { timestamp: Time.now.to_i }.merge( new_stats )
      stats_series  = stats_series.last(3)

      redis.set "#{youtube_id}_stats_series", stats_series.slice('view_count', 'subscriber_count').to_json
    end

    render( :json => stats_series.last ) and return if stats_series.length < 3

    stats_series = JSON.parse( redis.get( "#{youtube_id}_stats_series" ) )

    delta_t0 = stats_series.last['timestamp'] - stats_series.first['timestamp']
    moving_averages = {
      'view_count'       => (stats_series.last['view_count'] - stats_series.first['view_count'])             / delta_t0.to_f,
      'subscriber_count' => (stats_series.last['subscriber_count'] - stats_series.first['subscriber_count']) / delta_t0.to_f
    }

    delta_t1 = Time.now.to_i - stats_series.last['timestamp']    
    estimated_deltas = {
      'view_count'       => moving_averages['view_count']       * delta_t1,
      'subscriber_count' => moving_averages['subscriber_count'] * delta_t1
    }

    estimates = {
      'view_count'       => stats_series.last['view_count']       + (moving_averages['view_count']       * delta_t1),
      'subscriber_count' => stats_series.last['subscriber_count'] + (moving_averages['subscriber_count'] * delta_t1)
    }

    render :json => estimates
  end

  
  
end

