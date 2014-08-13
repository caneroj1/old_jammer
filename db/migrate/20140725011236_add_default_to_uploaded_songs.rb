class AddDefaultToUploadedSongs < ActiveRecord::Migration
  def change
  	change_column :users, :uploaded_songs, :integer, :default => 0
  end
end
