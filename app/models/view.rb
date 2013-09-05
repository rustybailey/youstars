class View < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  has_many   :unique_views

  attr_accessible :user_id, :video_id, :weight, :unique_view_count

  def update_unique_view_count
    update_attributes( :unique_view_count => unique_views.count )
  end

end
