module Bragi

  @@block_width = 64
  @@block_count = 2048
  @@k           = 2

  def register_watch(user, video, block_width = @@block_width, block_count = @@block_count, k = @@k)
    video_filter_name   = "#{user.guid}_video_filter"
    channel_filter_name = "#{user.guid}_channel_filter"

    video_filter   = Bloomfilter.new(video_filter_name,   block_width, block_count, k)
    channel_filter = Bloomfilter.new(channel_filter_name, block_width, block_count, k)

    video_filter.add_element(video.youtube_id)
    channel_filter.add_element(YoutubeApi.video_data_for_video_id(video.youtube_id)[:channel_id])    
  end

  def test_video(user, video, block_width = @@block_width, block_count = @@block_count, k = @@k)
    video_filter_name = "#{user.guid}_video_filter"
    video_filter      = Bloomfilter.new(video_filter_name, block_width, block_count, k)
    
    video_filter.test_element(video.youtube_id)
  end

  def test_channel(user, channel, block_width = @@block_width, block_count = @@block_count, k = @@k)
    channel_filter_name = "#{user.guid}_channel_filter"
    channel_filter      = Bloomfilter.new(channel_filter_name, block_width, block_count, k)

    channel_filter.test_element(channel.youtube_id)
  end

end
