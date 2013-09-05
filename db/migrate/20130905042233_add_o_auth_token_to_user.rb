class AddOAuthTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :oauth2_token, :string
  end
end
