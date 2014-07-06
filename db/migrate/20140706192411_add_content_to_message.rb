class AddContentToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :return_email, :string
    add_column :messages, :message_body, :text
    add_column :messages, :lesson_request, :boolean
    add_column :messages, :booking_request, :boolean
    add_column :messages, :jam_request, :boolean
  end
end
