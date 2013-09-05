class View < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  has_many   :unique_views

  attr_accessible :user_id, :video_id, :weight
end
