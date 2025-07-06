# BitChat - Real-time Chat Application

<div align="center">
  <h1>
    <svg width="60" height="60" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" stroke="#FF6B35" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
    <br>
    BitChat
  </h1>
  <p>
    <strong>Современное веб-приложение для общения в реальном времени</strong>
  </p>
  <p>
    <a href="#features">Возможности</a> •
    <a href="#tech-stack">Технологии</a> •
    <a href="#installation">Установка</a> •
    <a href="#usage">Использование</a> •
    <a href="#contributing">Вклад в проект</a>
  </p>
</div>

## 🚀 О проекте

BitChat - это современное веб-приложение для обмена сообщениями в реальном времени, построенное на Ruby on Rails 8. Приложение предоставляет удобный интерфейс для общения, систему достижений, уровней и полнофункциональный поиск пользователей.

## ✨ Features

### Основные возможности
- 💬 **Чат в реальном времени** - мгновенный обмен сообщениями через WebSockets
- 🔍 **Умный поиск пользователей** - поиск по имени, фамилии и логину с задержкой в 1 секунду
- 👤 **Профили пользователей** - персонализированные страницы с аватарами
- 🏆 **Система достижений** - награды за активность в приложении
- 📈 **Уровни и опыт** - геймификация процесса общения
- 📱 **Адаптивный дизайн** - оптимизация для мобильных устройств и десктопов
- 🌐 **Мультиязычность** - поддержка русского и английского языков

### Безопасность
- 🔐 Аутентификация через Devise
- 🛡️ Защита от DDoS с помощью Rack::Attack
- 🔒 CSRF защита
- ✅ Валидация email через valid_email2

## 🛠 Tech Stack

### Backend
- **Ruby** 3.3.6
- **Rails** 8.0.1
- **PostgreSQL** - основная база данных
- **Redis** - для ActionCable и кеширования
- **Solid Queue** - фоновые задачи
- **Solid Cable** - WebSocket соединения
- **Solid Cache** - кеширование

### Frontend
- **Hotwire** (Turbo + Stimulus) - интерактивность без написания много JavaScript
- **Tailwind CSS** - современная утилитарная CSS библиотека
- **ViewComponent** - компонентный подход к представлениям

### Инструменты разработки
- **RSpec** - тестирование
- **FactoryBot** - фабрики для тестов
- **Faker** - генерация тестовых данных
- **RuboCop** - линтер кода (rubocop-rails-omakase)
- **Kamal** - деплой в production
- **Docker** - контейнеризация

## 📋 Требования

- Ruby 3.3.6 или выше
- PostgreSQL 14 или выше
- Redis 6 или выше
- Node.js 18 или выше (для Tailwind CSS)
- Yarn или npm

## 🚀 Installation

### 1. Клонирование репозитория

```bash
git clone https://github.com/jonny-faringheit/chat_app.git
cd chat_app
```

### 2. Установка зависимостей

```bash
# Установка Ruby gems
bundle install

# Установка JavaScript пакетов
yarn install
```

### 3. Настройка базы данных

```bash
# Создание базы данных
bin/rails db:create

# Выполнение миграций
bin/rails db:migrate

# Заполнение тестовыми данными (опционально)
bin/rails db:seed
```

### 4. Настройка переменных окружения

Создайте файл `.env` в корне проекта или используйте Rails credentials:

```bash
# Редактирование credentials
bin/rails credentials:edit
```

### 5. Запуск приложения

```bash
# Запуск с Tailwind CSS watcher
bin/dev

# Или только Rails сервер
bin/rails server
```

Приложение будет доступно по адресу: http://localhost:3000

## 🎮 Usage

### Регистрация и вход
1. Перейдите на страницу регистрации `/users/signup`
2. Заполните форму регистрации
3. Подтвердите email (в development режиме письма можно увидеть в логах)

### Поиск пользователей
- Используйте поле поиска в шапке сайта
- Начните вводить имя, фамилию или логин
- Результаты появятся автоматически через 1 секунду

### Обмен сообщениями
1. Найдите пользователя через поиск
2. Перейдите в его профиль
3. Начните диалог

### Система достижений
- Получайте достижения за различные действия
- Просматривайте свой прогресс в разделе "Достижения"
- Повышайте уровень за активность

## 🧪 Тестирование

```bash
# Запуск всех тестов
bundle exec rspec

# Запуск конкретного файла
bundle exec rspec spec/models/user_spec.rb

# Запуск с покрытием кода
COVERAGE=true bundle exec rspec
```

## 🔧 Разработка

### Код стиль

```bash
# Проверка кода
bundle exec rubocop

# Автоисправление
bundle exec rubocop -a
```

### База данных

```bash
# Откат миграции
bin/rails db:rollback

# Пересоздание базы данных
bin/rails db:drop db:create db:migrate
```

### Консоль

```bash
# Rails консоль
bin/rails console

# Песочница (изменения не сохраняются)
bin/rails console --sandbox
```

## 🚀 Deployment

Проект настроен для деплоя с помощью Kamal:

```bash
# Первый деплой
kamal setup

# Последующие деплои
kamal deploy
```

## 🤝 Contributing

1. Fork репозитория
2. Создайте feature branch (`git checkout -b feature/amazing-feature`)
3. Commit изменения (`git commit -m 'Add some amazing feature'`)
4. Push в branch (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

### Правила для контрибьюторов
- Следуйте Ruby Style Guide
- Пишите тесты для новой функциональности
- Обновляйте документацию при необходимости
- Убедитесь, что все тесты проходят

## 📝 License

Этот проект лицензирован под MIT License - смотрите файл [LICENSE](LICENSE) для деталей.

## 👥 Авторы

- **Jonny Faringheit** - *Основная работа* - [YourGitHub](https://github.com/jonny-faringheit)

## 🙏 Благодарности

- Ruby on Rails сообществу
- Всем контрибьюторам проекта
- Открытым библиотекам, использованным в проекте

---

<div align="center">
  Сделано с ❤️ используя Ruby on Rails
</div>
