class PiggyBank < ApplicationRecord
  before_create :update_total_values
  belongs_to :user

  def update_total_values
    if self.balance.positive?
      self.total_credit += balance
    else
      self.total_debit += balance.abs
    end
  end

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
