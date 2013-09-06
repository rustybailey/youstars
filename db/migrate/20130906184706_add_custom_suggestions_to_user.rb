class AddCustomSuggestionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :custom_suggestions, :text
  end
end
