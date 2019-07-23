class NotificationWorker
  include Sneakers::Worker
  from_queue "notification"

  def work(msg)
    sleep 2000
    puts msg.to_json
    ack!
  rescue StandardError
    reject!
  end
end
