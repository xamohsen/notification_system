notification_types = %w(push_notification email sms)
FactoryBot.define do
  factory :notification do
    notification_type {notification_types[rand(max = 2)]}
  end
end