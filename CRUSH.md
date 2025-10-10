# CRUSH.md - Development Guide for Chat Rails

## Build/Lint/Test Commands

### Testing
- Run all tests: `bundle exec rspec`
- Run single test file: `bundle exec rspec spec/models/user_spec.rb`
- Run single test: `bundle exec rspec spec/models/user_spec.rb:10`
- Run with coverage: `COVERAGE=true bundle exec rspec`

### Linting
- Check code style: `bundle exec rubocop`
- Auto-fix issues: `bundle exec rubocop -a`
- Security check: `bundle exec brakeman`

### Database
- Run migrations: `bin/rails db:migrate`
- Rollback migration: `bin/rails db:rollback`
- Seed data: `bin/rails db:seed`
- Console: `bin/rails console`

### Development
- Start app with CSS watcher: `bin/dev`
- Start Rails server: `bin/rails server`

## Code Style Guidelines

### Ruby/Rails
- Follow rubocop-rails-omakase style guide
- Use 2-space indentation
- Prefer single quotes for strings unless interpolation needed
- Use snake_case for variables and methods
- Use CamelCase for classes and modules
- Use SCREAMING_SNAKE_CASE for constants

### Models
- Include concerns at top of class
- Use validates with clear messages
- Use has_many/belongs_to associations with dependent: :destroy where appropriate
- Use before_ and after_ callbacks sparingly
- Keep methods small and focused

### Controllers
- Include concerns at top of class
- Use before_action for common setup
- Keep actions thin - move logic to services or models
- Use strong parameters
- Follow RESTful conventions

### Testing (RSpec)
- Use factory_bot for test data
- Group tests with describe/context/it
- Use let/let! for test setup
- Test both happy path and edge cases
- Use subject where appropriate

### Views
- Use Tailwind CSS utility classes
- Keep views simple - move complex logic to helpers
- Use partials for reusable components
- Follow Rails naming conventions

### JavaScript
- Use Stimulus controllers for interactivity
- Keep JavaScript minimal with Hotwire approach
- Use import maps for dependency management