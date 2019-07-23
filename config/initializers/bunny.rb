MESSAGING_SERVICE = MessagingService.new({:host => "rabbitmq", :user => "rabbitmq", :password => "rabbitmq"})
MESSAGING_SERVICE.start
#MESSAGING_SERVICE.subscribe_to_queue 'sms'