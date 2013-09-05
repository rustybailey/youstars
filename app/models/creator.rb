class Creator < ActiveRecord::Base

  has_and_belongs_to_many :topics

  validates :name, :uniqueness => true
  validates :youtube_id, :uniqueness => true
end
