require 'youtube_api.rb'
require 'parts_of_speech.rb'

module Pythia
  
  def self.related(channel_id, limit = 40, stats_weighting = 0.5, width = 15)
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

    target_channel_data = YoutubeApi.channel_data_for_channel_id(channel_id)[0]
    description_space   = channels.collect { |c| c[:description] }

    channels.sort do |a, b|
      # descending

      Pythia.score(b, channel_videos[b[:channel_id]], target_channel_data, description_space, stats_weighting) <=>
        Pythia.score(a, channel_videos[a[:channel_id]], target_channel_data, description_space, stats_weighting) 

    end
  end


  def self.score(channel_data, initial_score, target_data = nil, data_space = nil, stats_weighting = 0.5)
    score = Math.log( channel_data[:subscriber_count] ) * initial_score
    score = score ** stats_weighting    

    if target_data.present? and data_space.present? and target_data.dig(:description).length > 0
      score *= Pythia.string_score(channel_data.dig(:description), target_data.dig(:description), data_space)
    end    
    
    score
  end


  def self.cheap_related(channel_id, limit = 50, width = 3)
    top_videos = YoutubeApi.video_search_for_channel_id(channel_id, width, 'viewCount')

    related_videos = top_videos.collect do |video|
      YoutubeApi.related_videos_for_video_id( video[:video_id] )
    end
    related_videos.flatten!

    channels = []
    related_videos.each do |video|
      channels << video[:channel_id] unless video[:channel_id] == channel_id
    end

    channels = channels.first(limit)

    channels = YoutubeApi.channel_data_for_channel_id(channels)
  end


  def self.string_score(target_0, target_1, space)
    # a TF-IDF mutual relevancy algorithm
    stop_words = PartsOfSpeech::StopWords

    # depunctuate and split
    target_0 = target_0.downcase.split.collect { |t| t.gsub( /\W/, '' ) }.reject { |t| t.in? stop_words or t.length < 3 }.compact
    target_1 = target_1.downcase.split.collect { |t| t.gsub( /\W/, '' ) }.reject { |t| t.in? stop_words or t.length < 3 }.compact
    
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


  def self.channel_score_by_topics(channel_0, channel_1)
    target_0 = channel_0.all_topics
    target_1 = channel_1.all_topics

    common_terms = target_0 & target_1

    subscores = common_terms.inject({}) do |hash, term|
      
      term_frequency_0 = 1 / Math.log( target_0.count )
      term_frequency_1 = 1 / Math.log( target_1.count )

      inverse_document_frequency = Math.log( Channel.count.to_f / term.total )

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
