class CreateChannelsTopicsTable < ActiveRecord::Migration

  def change
    create_table :channels_topics, :id => false do |t|
      t.references :channel
      t.references :topic
    end

    add_index :channels_topics, [:channel_id, :topic_id]
    add_index :channels_topics, :topic_id
  end

end
