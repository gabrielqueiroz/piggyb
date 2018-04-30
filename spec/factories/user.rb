FactoryBot.define do
  factory :user, class: User do
    id 1
    name 'Gabriel Queiroz'
    email 'gabriel.queiroz@test.com'
    password 'test'
    password_confirmation 'test'
  end
end
