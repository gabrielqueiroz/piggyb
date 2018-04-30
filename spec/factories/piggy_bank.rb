FactoryBot.define do
  factory :piggy_bank, class: PiggyBank do
    id 1
    name 'PS4 Games'
    currency 'CAD'
    description 'My PS4 Games'
    balance 200.0
    total_credit 300.0
    total_debit 100.0

    user_id 1
  end
end
