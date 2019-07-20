class MessageController < ApplicationController

  def create
    @message = Message.create!(message_params)
    json_response @message, :created
  end
  def update
    @message = Message.find params[:message][:id]
    @message.update(message_params)
    json_response @message
  end
  def index
    json_response Message.all
  end
  def show
    json_response set_message
  end

  private

  def message_params
    if params and params[:message]
      params.require(:message).permit(:title, :body, :icon, :link_to)
    end
  end

  def set_message
    @message = Message.find(params[:id])
  end

end
