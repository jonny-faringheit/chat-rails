FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    login { Faker::Internet.username(specifier: 3..20, separators: %w[. _ -]) }
    password { 'password123' }
    password_confirmation { 'password123' }
    first_name { '' }
    last_name { '' }
    date_of_birth { nil }
  end
end
