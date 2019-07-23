class WorkerService
  include Sneakers::Worker
  from_queue 'downloads'

  def work(msg)
    puts msg
    ack!
  end
end
