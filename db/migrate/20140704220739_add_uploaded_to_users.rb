class AddUploadedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uploaded, :boolean, default: false
  end
end
