Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 0.5
end

Sidekiq::Cron::Job.create(name: 'Check Armor and Weapons every 1 minute.', cron: '* * * * *', class: 'SentinelWorker')
