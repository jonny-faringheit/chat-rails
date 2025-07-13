# config/initializers/sidekiq_cron.rb
if defined?(Sidekiq)
  Sidekiq::Cron::Job.create(
    name: 'Mark Inactive Users Offline',
    cron: '*/1 * * * *', # Every minute
    class: 'MarkInactiveUsersOfflineJob',
    queue: 'low',
    description: 'Marks users as offline if they have not been active for 5 minutes'
  )
end