class ApplicationController < ActionController::API
  before_action :set_local, :set_providers

  include Response
  include ExceptionHandler
  def messaging_service
    MESSAGING_SERVICE
  end
  def set_providers
    $sms ||= TextMessenger.new
    $push_notification ||= PushNotification.new
    $providers = {
        'sms' => $sms,
        'push_notification' => $push_notification,
    }
  end
  def set_local (local = 'en')
    I18n.locale = params[:local] || local
  end
end
