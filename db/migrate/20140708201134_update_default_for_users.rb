class UpdateDefaultForUsers < ActiveRecord::Migration
  def change
  	change_column :users, :lessons, :boolean, :default => false
  end
end
