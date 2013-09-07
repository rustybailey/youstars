class VideoRating < ActiveRecord::Base

  has_one :user
  has_one :video
  
end
