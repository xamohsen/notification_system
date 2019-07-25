class PushNotification
  def send (message)
    puts "Push notification sent: ", message
  end

  def send_group (message)
    puts "Push notification to group sent: ", message
  end
end