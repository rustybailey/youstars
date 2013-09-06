class AddTotalToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :total, :integer
  end
end
