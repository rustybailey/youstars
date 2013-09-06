module GatherChannelData
  @queue = :high

  def self.perform(channel_id)
    channel = Channel.find channel_id

    calculate_topics_from_videos(channel)
  end

  def self.calculate_topics_from_videos(channel)
    topics      = []
    topic_freq  = Hash.new(0)

    page_token = nil
    loop do
      video_list = YoutubeApi.video_list(channel.youtube_id, 50, page_token)
      Rails.logger.warn(JSON.pretty_generate(video_list))

      video_list[:videos].each do |video|
        topics += video[:topics]
        video[:topics].inject(topic_freq) { |hash, topic| hash[topic] += 1; hash }
      end

      page_token = video_list[:page_token]
      break if page_token.nil?
    end

    return topics.uniq.sort_by { |n| topic_freq[n] }.reverse[0...32]
    topics.uniq.sort_by { |n| topic_freq[n] }.reverse[0...32].each do |topic|
      channel.calculated_topics.create(name: topic)
    end
  end

end
