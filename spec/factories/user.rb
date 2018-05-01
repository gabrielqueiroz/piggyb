FactoryBot.define do
  factory :user, class: User do
    name 'Gabriel Queiroz'
    email 'gabriel.queiroz@test.com'
    password 'test'
    password_confirmation 'test'

    trait :random_email do
      sequence(:email) { |n| "gabriel.queiroz#{n}@test.com" }
    end
  end
end
