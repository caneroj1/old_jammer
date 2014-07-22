class AddUpdatedReplies < ActiveRecord::Migration
  def change
  	create_table :replies do |t|
  		t.text :reply_body
  		t.integer :sent_by
  		t.references :message
  	end
  end
end
