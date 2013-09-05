class AddUniqueViewCountToViews < ActiveRecord::Migration
  def change
    add_column :views, :unique_view_count, :integer
  end
end
