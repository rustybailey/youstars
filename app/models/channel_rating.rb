class ChannelRating < ActiveRecord::Base

  has_one :user
  has_one :channel
  
end
