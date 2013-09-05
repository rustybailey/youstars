class AddWeightToView < ActiveRecord::Migration
  def change
    add_column :views, :weight, :integer, :default => 0
  end
end
