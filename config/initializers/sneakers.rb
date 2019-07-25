require 'sneakers'

module Connection
  def self.sneakers
    @_sneakers ||= begin
      Bunny.new({:host => "rabbitmq", :user => "rabbitmq", :password => "rabbitmq"})
    end
  end
end


Sneakers.configure connection: Connection.sneakers,
                   workers: 10, # Number of per-cpu processes to run
                   log: STDOUT, # Log file
                   pid_path: 'sneakers.pid', # Pid file
                   timeout_job_after: 2.minutes, # Maximal seconds to wait for job
                   env: ENV['RAILS_ENV'], # Environment
                   durable: true, # Is queue durable?
                   ack: true, # Must we acknowledge?
                   heartbeat: 5 # Keep a good connection with broker

Sneakers.logger.level = Logger::INFO