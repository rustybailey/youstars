class UniqueView < ActiveRecord::Base
  belongs_to :view
  attr_accessible :youtube_id, :view_id

  after_create do 
    view.update_unique_view_count if view.present?
  end
  
end
