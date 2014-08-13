class AddSentByToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sent_by, :integer
  end
end
