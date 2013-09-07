require 'resque/errors'

class ChannelSuggestionWarmer

  @queue = :low

  def self.perform( user_id_batch )

    User.where( :id => user_id_batch ).find_each do |u|

      Ashurbanipal.new( Suggest::ChannelsController, u.uid ).send(["similar_to_recently_watched"])
      
    end

  end

end
