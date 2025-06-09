FactoryBot.define do
  factory :message do
    content { "MyText" }
    sender { nil }
    conversation { nil }
    read { false }
  end
end
