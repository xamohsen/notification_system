class AddLanguageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :language, :string
    add_column :users, :device_token, :string
    add_column :users, :phone_number, :string
    add_column :users, :push_notification_count, :integer
  end
end
