class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :youtube_id
      t.string :title

      t.timestamps
    end
  end
end
