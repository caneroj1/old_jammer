class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
    	t.text :body
    	t.integer :sent_by
      t.timestamps
    end
  end
end
