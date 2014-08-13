class AddGenreItemsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :g1, :string
    add_column :users, :g2, :string
    add_column :users, :g3, :string
    add_column :users, :g4, :string
    add_column :users, :g5, :string
  end
end
