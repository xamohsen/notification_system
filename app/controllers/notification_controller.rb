class NotificationController < ApplicationController

  def sendNotification
    user = User.find params[:user_id]
    message = Message.find(params[:message_id])
    if validate_notification_request message, user, params[:notification_type]
      notification = Notification.create notification_type: params[:notification_type],
                                         user_id: params[:user_id],
                                         message_id: params[:message_id]
      messaging_service.publish ({"notification" => notification.to_json, "to" => "one"}.to_json)
      json_response notification, :created
    else
      json_response nil, 400, "Request Error"

    end
  end

  def sendGroupNotification
    message = Message.find(params[:message_id])
    notifications = []
    errors = []
    params[:users].each do |user|
      db_user = User.find user['id']
      if validate_notification_request message, db_user, params[:notification_type]
        notification = Notification.create notification_type: params[:notification_type],
                                           user_id: db_user[:id],
                                           message_id: params[:message_id]
        notifications.push notification
      else
        errors.push ({message: "Error on notification with user_id: #{user[:id]} and message_id: #{params[:message_id]}"})
      end
    end
    if notifications.length > 0
      messaging_service.publish ({"notification" => notifications.to_json, "to" => "group"}.to_json)
    end
    json_response ({notifications: notifications, errors: errors}), :created
  end

  private

  def validate_notification_request(message, user, notification_type)
    if !user or
        !message or
        !notification_type or
        Notification.find_by(message_id: message[:id],
                             user_id: user[:id],
                             notification_type: notification_type) != nil or
        $providers[notification_type] == nil
      false
    else
      true
    end
  end
end
