class CreateCreators < ActiveRecord::Migration

  def change
    create_table :creators do |t|
      t.string :name
      t.string :youtube_id
      t.string :gender
      t.string :location
      t.string :description

      t.timestamps
    end
  end

end
