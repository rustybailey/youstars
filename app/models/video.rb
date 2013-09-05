class Video < ActiveRecord::Base
  has_many :views
  belongs_to :category

  attr_accessible :youtube_id, :category_id
end
