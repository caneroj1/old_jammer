class CreateUsersAndMessages < ActiveRecord::Migration
  def change
    create_table :users_and_messages, id: false do |t|
    	t.belongs_to :user
    	t.belongs_to :message
    end
  end
end
