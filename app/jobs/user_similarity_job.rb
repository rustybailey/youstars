class UserSimilarityJob
  @queue = :medium

  def self.perform(user_id)
    # evaluate user cosine similarities based on channel ratings
    #
    # if we decide to use channel likes instead of ratings, we
    # might want to consider finding the Jaccard coefficient instead

    u = User.find user_id
    return if u.nil?

    user_oauth_token = u.get_token   
    return if user_oauth_token.nil?


    # choose the most popular three channels from each rating tier,
    # and use their ratings to construct an 18-dimensional vector
    #
    # TODO: view count is maybe not the best measure of salience here, 
    # so consider looking for something else

    channel_vector = { }
    (0..5).each do |tier|

      channel_ids  = u.rated_channels(tier).collect { |c| c.youtube_id }
      channel_data = YoutubeApi.channel_data_for_channel_id( channel_ids )

      channel_data.sort! { |a, b| b[:view_count] <=> a[:view_count] } # descending

      channel_data.first(3).each do |cd|
        channel_vector[cd[:channel_id]] = tier
      end
    end


    # find other users who have ratings for the same channels, and
    # calculate matching ratings vectors for them

    other_vectors = { }
    User.each do |other_user|

      rated_channels = other_user.rated_channels.where( :youtube_id => channel_vector.keys )

      next if rated_channels.count != channel_vector.keys.count

      channel_vector.keys.each do |k|
        other_vectors[ other_user.youtube_id ][ k ] = rated_channels.where( :youtube_id => k ).score
      end

    end


    # find the cosine similarities between the target user and 
    # each of the the others
    
    similarities = { }

    other_vectors.each do |key, value|

      similarities[key] = cosine_similarity( channel_vector, value )

    end
    
    sorted_similarities = similarities.keys.sort do |a, b|
      similarities[b] <=> similarities[a] # descending
    end


    # then record similarities in Redis

    redis = Resque.redis    
    redis.set( "#{ user_id }_similar", sorted_similarities )
  end

  
  def cosine_similarity(a, b)
    
    dot_product = a.keys.inject(0) do |sum, key|
      sum += a[key] * b[key]
    end

    magnitude_a = a.keys.inject(0) do |sum, key|
      sum += a[key] ** 2
    end
    magnitude_a **= 0.5

    magnitude_b = b.keys.inject(0) do |sum, key|
      sum += b[key] ** 2
    end
    magnitude_b **= 0.5


    dot_product.to_f / ( magnitude_a * magnitude_b )
  end

end
