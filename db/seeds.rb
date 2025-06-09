# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Achievements
achievements_data = [
  # Communication achievements
  {
    key: "first_message",
    name: "Первое слово",
    description: "Отправить первое сообщение",
    icon: "💬",
    category: "communication",
    points: 10,
    tier: 1
  },
  {
    key: "talkative",
    name: "Разговорчивый",
    description: "Отправить 100 сообщений",
    icon: "🗣️",
    category: "communication",
    points: 50,
    tier: 2
  },
  {
    key: "speaker",
    name: "Оратор",
    description: "Отправить 1000 сообщений",
    icon: "📢",
    category: "communication",
    points: 100,
    tier: 3
  },
  {
    key: "chat_legend",
    name: "Легенда чата",
    description: "Отправить 10000 сообщений",
    icon: "👑",
    category: "communication",
    points: 500,
    tier: 4
  },

  # Social achievements
  {
    key: "first_contact",
    name: "Первый контакт",
    description: "Начать первый диалог с другим пользователем",
    icon: "🤝",
    category: "social",
    points: 20,
    tier: 1
  },
  {
    key: "friendly",
    name: "Дружелюбный",
    description: "Иметь 10 активных диалогов",
    icon: "👥",
    category: "social",
    points: 50,
    tier: 2
  },
  {
    key: "popular",
    name: "Популярный",
    description: "Иметь 50 контактов",
    icon: "🌟",
    category: "social",
    points: 100,
    tier: 3
  },
  {
    key: "social_butterfly",
    name: "Социальная бабочка",
    description: "Иметь 100 контактов",
    icon: "🦋",
    category: "social",
    points: 200,
    tier: 4
  },

  # Activity achievements
  {
    key: "regular_visitor",
    name: "Постоянный гость",
    description: "Заходить на сайт 7 дней подряд",
    icon: "📅",
    category: "activity",
    points: 30,
    tier: 1
  },
  {
    key: "on_fire",
    name: "В огне",
    description: "Заходить на сайт 30 дней подряд",
    icon: "🔥",
    category: "activity",
    points: 100,
    tier: 2
  },
  {
    key: "unstoppable",
    name: "Неугомонный",
    description: "Заходить на сайт 100 дней подряд",
    icon: "⚡",
    category: "activity",
    points: 300,
    tier: 3
  },
  {
    key: "veteran",
    name: "Ветеран",
    description: "Быть на сайте 365 дней",
    icon: "🎖️",
    category: "activity",
    points: 1000,
    tier: 4
  },

  # Special achievements
  {
    key: "night_owl",
    name: "Полуночник",
    description: "Отправить сообщение после полуночи",
    icon: "🦉",
    category: "special",
    points: 25,
    tier: 1
  },
  {
    key: "early_bird",
    name: "Ранняя пташка",
    description: "Отправить сообщение до 6 утра",
    icon: "🌅",
    category: "special",
    points: 25,
    tier: 1
  },
  {
    key: "birthday",
    name: "День рождения",
    description: "Провести год на платформе",
    icon: "🎂",
    category: "special",
    points: 200,
    tier: 3
  },
  {
    key: "perfectionist",
    name: "Перфекционист",
    description: "Полностью заполнить профиль",
    icon: "✨",
    category: "special",
    points: 50,
    tier: 2
  },

  # Level achievements
  {
    key: "level_10",
    name: "Новичок",
    description: "Достичь 10 уровня",
    icon: "🎯",
    category: "level",
    points: 50,
    tier: 1
  },
  {
    key: "level_25",
    name: "Опытный",
    description: "Достичь 25 уровня",
    icon: "🏅",
    category: "level",
    points: 150,
    tier: 2
  },
  {
    key: "level_50",
    name: "Мастер",
    description: "Достичь 50 уровня",
    icon: "🏆",
    category: "level",
    points: 500,
    tier: 3
  },
  {
    key: "level_100",
    name: "Гранд-мастер",
    description: "Достичь максимального уровня",
    icon: "💎",
    category: "level",
    points: 2000,
    tier: 4
  }
]

achievements_data.each do |achievement_data|
  Achievement.find_or_create_by!(key: achievement_data[:key]) do |achievement|
    achievement.assign_attributes(achievement_data)
  end
end

puts "Created #{Achievement.count} achievements"
