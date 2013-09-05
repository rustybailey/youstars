require 'youtube_api'

class CreatorController < ApplicationController

  def videos
    youtube_id = params[:youtube_id]
    page_token = params[:page_token]
    limit      = 20

    video_list = YoutubeApi.video_list(youtube_id, limit, page_token)

    render :json => video_list
  end
  
end
