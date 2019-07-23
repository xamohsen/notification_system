
class NotificationController < ApplicationController

  def sendOneNotification
    user = User.find params[:user_id]
    message = Message.find params[:message_id]
    if !user or !message
      json_response nil
    else
      notification = Notification.create notification_type: params[:notification_type],
                                         user_id: params[:user_id],
                                         message_id: params[:message_id]
      messaging_service.publish "notification.as_json", 'sms'
      json_response notification, :created
    end
  end
end
