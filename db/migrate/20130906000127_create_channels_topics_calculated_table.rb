class CreateChannelsTopicsCalculatedTable < ActiveRecord::Migration

  def change
    create_table :channels_topics_calculated, :id => false do |t|
      t.references :channel
      t.references :topic
    end

    add_index :channels_topics_calculated, [:channel_id, :topic_id]
    add_index :channels_topics_calculated, :topic_id
  end

end
