class CreateUniqueViews < ActiveRecord::Migration
  def change
    create_table :unique_views do |t|
      t.integer :view_id
      t.string :youtube_id

      t.timestamps
    end
  end
end
