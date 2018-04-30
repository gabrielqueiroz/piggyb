FactoryBot.define do
  factory :movement, class: Movement do
    id 1
    name 'God of War'
    description 'Bought at EBGames Burnaby Canada'
    amount -60.0

    piggy_bank_id 1
  end
end
