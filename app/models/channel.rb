class Channel < ActiveRecord::Base

  has_many                :videos
  has_and_belongs_to_many :topics,
                          :after_add    => :increment_topic_total,
                          :after_remove => :decrement_topic_total
  has_and_belongs_to_many :calculated_topics,
                          :class_name   => 'Topic',
                          :join_table   => 'channels_topics_calculated',
                          :after_add    => :increment_topic_total,
                          :after_remove => :decrement_topic_total

  validates :name, :uniqueness => true
  validates :youtube_id, :uniqueness => true

  def increment_topic_total(topic)
    topic.total ||= 0
    topic.total  += 1
    topic.save
  end

  def decrement_topic_total(topic)
    topic.total -= 1
    topic.save
  end

end
