class NotificationController < ApplicationController

  def sendOneNotification
    user = User.find params[:user_id]
    message = Message.find(params[:message_id])
    if validate_notification_request message, user, params[:notification_type]
      notification = Notification.create notification_type: params[:notification_type],
                                         user_id: params[:user_id],
                                         message_id: params[:message_id]
      messaging_service.publish notification.to_json
      json_response notification, :created
    end
  end


  private

  def validate_notification_request(message, user, notification_type)
    if !user or !message or !notification_type
      json_response nil
      false
    elsif Notification.find_by(message_id: message[:id],
                               user_id: user[:id],
                               notification_type: notification_type) != nil
      json_response nil, 405, "This message along side the user is already exist"
      false
    elsif $providers[notification_type] == nil
      puts $providers[notification_type], notification_type
      json_response nil, 404, "Notification Type is't supported yet, please try again later"
      false
    else
      true
    end
  end
end
