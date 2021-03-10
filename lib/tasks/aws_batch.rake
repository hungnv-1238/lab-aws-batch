namespace :batch do
  desc "First demo job on aws batch"
  task first_demo: :environment do
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    12.times do
      logger.info "Task 'first demo' is running..."
      sleep 10
    end
  end
end
