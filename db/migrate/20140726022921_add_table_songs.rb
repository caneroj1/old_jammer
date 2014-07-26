class AddTableSongs < ActiveRecord::Migration
  def change
  	create_table :songs do |t|
  		t.string :song_name
  		t.string :url
  		t.integer :song_number
  		t.references :user
  	end
  end
end
