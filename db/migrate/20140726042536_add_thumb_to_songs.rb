class AddThumbToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :thumb, :string
  end
end
