class MessagingService
  def initialize (config)
    @bunny = Bunny.new(config)
    @bunny.start
    at_exit {@bunny.stop}
  end

  attr_reader :bunny, :exchange

  def start
    bunny.start
  end

  def publish(message, routing_key)
    start_exchange(routing_key).publish(message, :routing_key => routing_key)
  end


  def start_exchange (routing_key)
    @exchange ||= channel.direct('notification', durable: true)
    queue ||= channel.queue('notification', durable: true, :auto_delete => false)
                  .bind(@exchange, :routing_key => routing_key)
    @exchange
  end

  def channel
    @channel ||= bunny.channel
  end


  def subscribe_to_queue(routing_key)
    queue ||= channel.queue('notification', durable: true, :auto_delete => false)
                  .bind(exchange, :routing_key => routing_key)

    queue.subscribe(block: true, manual_ack: true) do |delivery_info, _properties, payload|
      channel.ack(delivery_info.delivery_tag) unless Rails.env.development?

      begin
        payload = JSON.parse(payload)
        handle_payload(payload)
      rescue StandardError => e
        puts "Error processing: #{e.message}"
        puts e.backtrace
      end
    end
  end

  def handle_payload(payload)
    puts payload
  end

end
