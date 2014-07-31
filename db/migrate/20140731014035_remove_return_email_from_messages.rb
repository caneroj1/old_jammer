class RemoveReturnEmailFromMessages < ActiveRecord::Migration
  def change
  	remove_column :messages, :return_email
  end
end
