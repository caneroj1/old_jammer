class RenameUsersAndMessages < ActiveRecord::Migration
  def change
  	rename_table :users_and_messages, :messages_users
  end
end
