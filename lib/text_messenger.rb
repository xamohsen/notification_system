class TextMessenger

  def send (message)
    # client = Twilio::REST::Client.new
    # client.messages.create({
    #                            from: Rails.application.secrets.twilio_phone_number,
    #                            to: 'YOUR PERSONAL PHONE NUMBER GOES HERE',
    #                            body: message
    #                        })
    raise 'An error has occurred'
    puts "SMS sent: ", message
  end

  def send_group (message)
    puts "SMS to group sent: ", message
  end
end