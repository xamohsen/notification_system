class ApplicationController < ActionController::API
  before_action :set_local

  include Response
  include ExceptionHandler
  def messaging_service
    MESSAGING_SERVICE
  end
  def set_local
    I18n.locale = params[:local] || 'en'
  end
end
