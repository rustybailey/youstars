class Topic < ActiveRecord::Base

  has_and_belongs_to_many :channels

  validates :name, :uniqueness => true

  def name= (name)
    write_attribute(:name, name.downcase)
  end

end
