module GatherChannelData
  @queue = :high

  def self.perform(channel_id)
    channel = Channel.find channel_id

    calculate_base_topics(channel)
  end

  def self.calculate_base_topics(channel)
    tags      = []
    tag_freq  = Hash.new(0)

    page_token = nil
    loop do
      video_list = YoutubeApi.video_list(channel.youtube_uid, 50, page_token)

      video_list[:videos].each do |video|
        tags += video[:tags]
        video[:tags].inject(tag_freq) { |hash, tag| hash[tag] += 1; hash }
      end

      page_token = video_list[:page_token]
      break if page_token.nil?
    end

    tags.uniq.sort_by { |n| tag_freq[n] }.reverse
  end

end
