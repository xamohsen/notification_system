class Notification < ApplicationRecord
  belongs_to :message, foreign_key: 'message_id'
  belongs_to :user, foreign_key: 'user_id'
  validates_presence_of :user_id, :message_id, :notification_type
end
