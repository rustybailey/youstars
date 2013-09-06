class Channel < ActiveRecord::Base

  has_and_belongs_to_many :topics

  has_many :videos

  validates :name, :uniqueness => true
  validates :youtube_id, :uniqueness => true

end
