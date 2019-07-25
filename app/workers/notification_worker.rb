require 'json'

class NotificationWorker
  include Sneakers::Worker
  from_queue "notification"

  def work(notification)
    retries = 0
    $sms ||= TextMessenger.new
    $push_notification ||= PushNotification.new
    $providers = {
        'sms' => $sms,
        'push_notification' => $push_notification,
    }
    notification = JSON.parse(notification)
    begin
      user = User.find notification['user_id']
      set_local(user)
      message = Message.find notification['message_id']
      $providers[notification['notification_type']].send create_message(message, user)
      ack!
    rescue Exception => e
      if retries < 10
        puts "FAIL retry: #{retries} notification: #{notification}"
        puts e
        retries += 1
        sleep 5
        retry
      else
        puts "rejected"
        reject!
      end
    end
  end
  private

  def set_local(user)
    I18n.locale = user['language'] != nil ? user['language'] : 'en'
  end

  def create_message(message, user)
    {
        phone_number: user[:phone_number],
        device_token: user[:device_token],
        email: user[:email],
        title: message[:title],
        body: message[:body],
    }
  end
end
