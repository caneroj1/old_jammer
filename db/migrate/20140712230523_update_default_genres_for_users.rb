class UpdateDefaultGenresForUsers < ActiveRecord::Migration
  def change
  	change_column :users, :genres, :text, :default => ""
  end
end
