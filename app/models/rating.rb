class Rating < ActiveRecord::Base

  has_one :channel
  has_one :video
  
end
