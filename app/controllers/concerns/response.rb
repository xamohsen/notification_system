module Response
  def json_response(object, status = :ok, message= "Not Found")
    if object == nil
      render json: {message: message}, status: :not_found
    else
      render json: object.as_json, status: status
    end
  end
end

module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({message: e.message}, :not_found)
    end
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({message: e.message}, :unprocessable_entity)
    end
    rescue_from ActiveRecord::RecordNotSaved do |e|
      json_response({message: e.message}, :unprocessable_entity)
    end
  end
end