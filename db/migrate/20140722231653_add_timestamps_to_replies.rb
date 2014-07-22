class AddTimestampsToReplies < ActiveRecord::Migration
  def change
  	change_table :replies do |t|
  		t.timestamps
  	end
  end
end
