require 'json'

class NotificationWorker
  include Sneakers::Worker
  from_queue "notification"

  def work(data)
    retries = 0
    begin
      data = JSON.parse(data)
      notification = data['notification']
      to = data['to']
      $sms ||= TextMessenger.new
      $push_notification ||= PushNotification.new
      $providers = {
          'sms' => $sms,
          'push_notification' => $push_notification,
      }
      if to == 'one'
        send_notification notification
      elsif to == 'group'
        send_group_notification(notification)
      end
    rescue Exception => e
      if retries < 10
        puts "FAIL retry: #{retries}"
        puts e
        retries += 1
        sleep 5
        retry
      else
        puts "rejected"
        reject!
      end
      ack!
    end
  end

  private

  def send_group_notification (notifications)
    notifications = JSON.parse(notifications)
    users = []
    notifications.each do |notification|
      users.push(User.find(notification['user_id']))
    end
    set_local('en')
    message = Message.find notifications[0]['message_id']
    $providers[notifications[0]['notification_type']].send_group create_group_message(message, users)
  end

  def send_notification(notification)
    notification = JSON.parse(notification)

    user = User.find notification['user_id']
    set_local(user['language'])
    message = Message.find notification['message_id']
    $providers[notification['notification_type']].send create_message(message, user)
  end

  def set_local(language)
    I18n.locale = language != nil ? language : 'en'
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

  def create_group_message(message, users)
    {
        users: users,
        title: message[:title],
        body: message[:body]
    }
  end

end
