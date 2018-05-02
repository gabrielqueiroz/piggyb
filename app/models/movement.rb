class Movement < ApplicationRecord
  before_save     :increase_piggy_bank
  before_destroy  :decrease_piggy_bank

  belongs_to      :piggy_bank

  private
  def increase_piggy_bank
    piggy_bank.on_movement_create(amount)
  end

  def decrease_piggy_bank
    piggy_bank.on_movement_destroy(amount)
  end

end
