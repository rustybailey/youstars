class AddGuidAndChannelNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :guid, :string
    add_column :users, :channel_name, :string
  end
end
