class ReplaceRatingsWithVideoRatingsAndChannelRatings < ActiveRecord::Migration
  def change
    drop_table :ratings

    create_table :video_ratings do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :score

      t.timestamps
    end

    create_table :channel_ratings do |t|
      t.integer :user_id
      t.integer :channel_id
      t.integer :score
      
      t.timestamps
    end

  end
end
