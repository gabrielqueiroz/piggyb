class Movement < ApplicationRecord

  before_save :update_piggy_bank

  private
  def update_piggy_bank
    piggy_bank = PiggyBank.find(piggy_bank_id)
    piggy_bank.balance += amount
    amount > 0 ? piggy_bank.total_credit += amount : piggy_bank.total_debit += amount
    piggy_bank.save
  end

end
