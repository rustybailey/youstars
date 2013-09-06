class Topic < ActiveRecord::Base

  has_and_belongs_to_many :channels
  has_and_belongs_to_many :channels_via_calculation,
                          :class_name => 'Channel',
                          :join_table => 'channels_topics_calculated'

  validates :name, :uniqueness => true

  attr_accessible :name

  def name= (name)
    write_attribute(:name, name.downcase)
  end

end
