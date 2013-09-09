module Bragi

  @@block_width = 64
  @@block_count = 2048
  @@k           = 2

  def self.register_view(user_id, video_id, block_width = @@block_width, block_count = @@block_count, k = @@k)
    video_filter_name   = "#{user_id}_video_filter"
    channel_filter_name = "#{user_id}_channel_filter"

    video_filter   = Bloomfilter.new(video_filter_name,   block_width, block_count, k)
    channel_filter = Bloomfilter.new(channel_filter_name, block_width, block_count, k)

    video_filter.add_element(video_id)
    channel_filter.add_element( YoutubeApi.video_data_for_video_ids(video_id)[0][:channel_id] )    
  end

  def self.test_video(user_id, video_id, block_width = @@block_width, block_count = @@block_count, k = @@k)
    video_filter_name = "#{user_id}_video_filter"
    video_filter      = Bloomfilter.new(video_filter_name, block_width, block_count, k)
    
    video_filter.test_element(video_id)
  end

  def self.test_channel(user_id, channel_id, block_width = @@block_width, block_count = @@block_count, k = @@k)
    channel_filter_name = "#{user_id}_channel_filter"
    channel_filter      = Bloomfilter.new(channel_filter_name, block_width, block_count, k)

    channel_filter.test_element(channel_id)
  end

end
