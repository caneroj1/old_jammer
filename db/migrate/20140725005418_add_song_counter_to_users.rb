class AddSongCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uploaded_songs, :integer
  end
end
