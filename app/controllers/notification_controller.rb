
class NotificationController < ApplicationController

  def sendOneNotification
    user = User.find params[:user_id]
    message = Message.find params[:message_id]
    if !user or !message or !params[:notification_type]
      json_response nil
    else
      notification = Notification.create notification_type: params[:notification_type],
                                         user_id: params[:user_id],
                                         message_id: params[:message_id]
      puts notification.to_json
      messaging_service.publish notification.to_json
      json_response notification, :created
    end
  end
end
