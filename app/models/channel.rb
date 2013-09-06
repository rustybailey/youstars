class Channel < ActiveRecord::Base

  has_and_belongs_to_many :topics

  has_many :videos
  has_many :ratings

  validates :name, :uniqueness => true
  validates :youtube_id, :uniqueness => true

  def rated_videos(score = nil)
    Video.where(:id => ratings_relation.map(&:id))
  end

  def liked_videos(score = 3)
    ratings_relation = ratings
    ratings_relation = ratings_relation.where( ["score >= ?", score] ) unless score.nil?

    Video.where(:id => ratings_relation.map(&:id))
  end

  def disliked_videos(score = 2)
    ratings_relation = ratings
    ratings_relation = ratings_relation.where( ["score <= ?", score] ) unless score.nil?

    Video.where(:id => ratings_relation.map(&:id))
  end

end
