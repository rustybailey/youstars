class Suggest::ChannelsController < ApplicationController

  def youtube
    # retrieve the n most popular videos for the target channel
    # then retrieve the related videos for those and find the
    # channels to which they belong
  end

  def topics
    # return the top n channels when sorted by topic overlap
    # tf-idf relevance
  end

  def ratings
    # return the top n channels sorted by ratings given by similar users
    # distance metric on vector space of ratings
    # and/or tf-idf relevance of positively-rated channels
  end

  def recently_watched
    # return the n most recently-watched channels with positive ratings
  end

end
