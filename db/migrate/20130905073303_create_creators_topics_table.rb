class CreateCreatorsTopicsTable < ActiveRecord::Migration

  def change
    create_table :creators_topics, :id => false do |t|
      t.references :creator
      t.references :topic
    end

    add_index :creators_topics, [:creator_id, :topic_id]
    add_index :creators_topics, :topic_id
  end

end
