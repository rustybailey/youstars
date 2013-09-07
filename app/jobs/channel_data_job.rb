module ChannelDataJob

  @queue = :medium

  def self.perform(channel_id)
    channel = Channel.find channel_id
    return if channel.nil?

    calculate_topics_from_videos(channel)
  end

  def self.calculate_topics_from_videos(channel)
    topics      = []
    topic_freq  = Hash.new(0)

    page_token = nil
    loop do
      video_list = YoutubeApi.video_list(channel.youtube_id, 50, page_token)

      video_list[:videos].each do |video|
        if video[:topics].present?
          topics += video[:topics]
          video[:topics].inject(topic_freq) { |hash, topic| hash[topic] += 1; hash }
        end
      end

      page_token = video_list[:page_token]
      break if page_token.nil?
    end

    # Only use the top 32 most frequently used tags/topics for this channel
    topics.uniq.sort_by { |n| topic_freq[n] }.reverse[0...32].each do |topic_name|
      channel.calculated_topics << Topic.find_or_create_by(name: topic_name)
    end

    #return { :topics => topics.uniq.sort_by { |n| topic_freq[n] }.reverse[0...32], :freq => topic_freq }
  end

end
