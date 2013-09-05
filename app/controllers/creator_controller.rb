require 'youtube_api'

class CreatorController < ApplicationController

  def show
    youtube_ids = params[:youtube_id].split(',')

    output = youtube_ids.collect do |youtube_id|
      Creator.find_by_youtube_id(youtube_id).attributes
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
        topics: Creator.find_by_youtube_id(youtube_id).topics.map(&:name)
      }
    end

    render :json => topics
  end
  
end
