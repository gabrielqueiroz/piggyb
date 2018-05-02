class PiggyBank < ApplicationRecord
  belongs_to :user

  def on_movement_create(amount)
    self.balance += amount
    if amount.positive?
      self.total_credit += amount
    else
      self.total_debit  += amount.abs
    end
    self.save
  end

  def on_movement_destroy(amount)
    self.balance -= amount
    if amount.positive?
      self.total_credit -= amount
    else
      self.total_debit  -= amount.abs
    end
    self.save
  end

end
