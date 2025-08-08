Rails.application.config.session_store :redis_session_store,
  key: "_chat_app_session",
  redis: {
    expire_after: 90.minutes,
    key_prefix: "chat_app:session:",
    url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0")
  }
