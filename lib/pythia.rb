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
    # geometric mean of subscribers and views 
    score = (channel_data[:subscriber_count] * channel_data[:view_count]) ** 0.5

    # penalize channels that don't have a description
    score *= 0.8 if channel_data[:description] == ""

    score
  end

  def self.string_score(target_0, target_1, space)
    stop_words = ['a', 'an', 'the', 'and', 'or']

    # depunctuate and split
    target_0 = target_0.downcase.split.collect { |t| t.gsub( /\W/, '' ) }.reject { |t| t.in? stop_words }.compact
    target_1 = target_1.downcase.split.collect { |t| t.gsub( /\W/, '' ) }.reject { |t| t.in? stop_words }.compact
    
    space = space.collect do |string|
      string.downcase.split.collect { |t| t.gsub( /\W/, '' ) }.reject { |t| t.in? stop_words }.compact
    end
    space.flatten!
    
    common_terms = target_0 & target_1

    subscores = common_terms.inject({}) do |hash, term|
      
      term_frequency_0 = (target_0.select { |t| t == term }.count) / target_0.count.to_f
      term_frequency_1 = (target_1.select { |t| t == term }.count) / target_1.count.to_f

      inverse_document_frequency = Math.log( space.count.to_f / (space.select { |t| t == term }.count) )

      hash.merge( { term => [term_frequency_0, term_frequency_1, inverse_document_frequency] } )
      
    end
    
    term_scores = {}
    subscores.each_pair do |k, v|
      term_scores[k] = v.inject(1) { |ac, v| ac * v }
    end

    sum = 0
    term_scores.each_pair do |k, v|
      sum += v
    end

    sum
  end
  
end
