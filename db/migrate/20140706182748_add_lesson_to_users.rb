class AddLessonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lessons, :boolean
  end
end
