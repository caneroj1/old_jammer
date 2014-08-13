class AddReferenceToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :references, :messages
  end
end
