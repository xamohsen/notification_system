class ApplicationController < ActionController::API
  before_action :set_local

  include Response
  include ExceptionHandler

  def set_local
    I18n.locale = params[:local] || 'en'
  end
end
