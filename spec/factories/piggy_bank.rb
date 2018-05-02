FactoryBot.define do
  factory :piggy_bank, class: PiggyBank do
    name 'PS4 Games'
    currency 'CAD'
    description 'My PS4 Games'
    balance 200.0
    total_credit 0.0
    total_debit 0.0

    association :user, factory: [:user, :random_email]
  end
end
