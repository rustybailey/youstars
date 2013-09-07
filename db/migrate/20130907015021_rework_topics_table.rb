class ReworkTopicsTable < ActiveRecord::Migration

  def up
    rename_column :topics, :name, :mid
    add_column    :topics, :name, :string
  end

  def down
    remove_column :topics, :name
    rename_column :topics, :mid, :name
  end

end
