module Pythia
  require 'youtube_api.rb'

  def self.related(channel_id, limit = 20, width = 15)
    top_videos = YoutubeApi.video_search_for_channel_id(channel_id, width, 'viewCount')

    related_videos = top_videos.collect do |video|
      YoutubeApi.related_videos_for_video_id( video[:video_id] )
    end
    related_videos.flatten!
    
    channel_videos = Hash.new(0)
    related_videos.each do |video|
      channel_videos[video[:channel_id]] += 1 unless video[:channel_id] == channel_id
    end
    
    channels = channel_videos.keys.sort { |a, b| channel_videos[b] <=> channel_videos[a] } # descending
    channels = channels.first(limit)
    
    channels = YoutubeApi.channel_data_for_channel_id(channels)

    channels.sort { |a, b| Pythia.score(b) <=> Pythia.score(a) } # descending
  end

  def self.score(channel_data)
    # geometric mean of subscribers and views for now

    (channel_data[:subscriber_count] * channel_data[:view_count]) ** 0.5
  end

end
