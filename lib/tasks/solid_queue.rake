namespace :solid_queue do
  desc "Clean up duplicate and old jobs"
  task cleanup: :environment do
    puts "Cleaning up Solid Queue..."

    # Удаляем старые выполненные джобы (старше 7 дней)
    old_finished = SolidQueue::Job
      .where.not(finished_at: nil)
      .where("finished_at < ?", 7.days.ago)
      .destroy_all
      .count

    puts "Deleted #{old_finished} old finished jobs"

    # Удаляем дубликаты MarkInactiveUsersOfflineJob
    duplicate_jobs = SolidQueue::Job
      .where(class_name: 'MarkInactiveUsersOfflineJob', finished_at: nil)
      .order(created_at: :desc)
      .offset(1) # Оставляем самую новую
      .destroy_all
      .count

    puts "Deleted #{duplicate_jobs} duplicate MarkInactiveUsersOfflineJob"
  end

  desc "Show queue statistics"
  task stats: :environment do
    puts "\n=== Solid Queue Statistics ==="
    puts "Total jobs: #{SolidQueue::Job.count}"
    puts "Pending: #{SolidQueue::Job.where(finished_at: nil).count}"
    puts "Finished: #{SolidQueue::Job.where.not(finished_at: nil).count}"

    puts "\n=== Jobs by class ==="
    SolidQueue::Job
      .group(:class_name)
      .count
      .sort_by { |_, count| -count }
      .first(10)
      .each do |class_name, count|
        pending = SolidQueue::Job.where(class_name: class_name, finished_at: nil).count
        puts "#{class_name}: #{count} total (#{pending} pending)"
      end
  end
end
