every 1.minute do
  runner "MarkInactiveUsersOfflineJob.perform_later"
end
