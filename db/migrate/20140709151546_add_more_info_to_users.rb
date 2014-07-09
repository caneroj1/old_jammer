class AddMoreInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :statement, :text
    add_column :users, :genres, :text
  end
end
