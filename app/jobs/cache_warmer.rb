require 'resque/errors'

class CacheWarmer

  @queue = :immediate

  def self.perform

    User.find_in_batches do |batch|
      
      Resque.enqueue( ChannelSuggestionWarmer, batch.collect { |u| u.id } )

    end

  end

end
