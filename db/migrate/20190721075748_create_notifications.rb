class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :message_id
      t.string :notification_type, :default => "push_notification"
      t.integer :status, :default => 0
      t.timestamps
    end
  end
end
