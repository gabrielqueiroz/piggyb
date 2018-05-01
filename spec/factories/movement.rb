FactoryBot.define do
  factory :movement, class: Movement do
    name 'God of War'
    description 'Bought at EBGames Burnaby Canada'
    amount -60.0

    association :piggy_bank, factory: :piggy_bank
  end
end
