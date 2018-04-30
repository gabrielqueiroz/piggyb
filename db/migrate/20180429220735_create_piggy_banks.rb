class CreatePiggyBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :piggy_banks do |t|
      t.string :name
      t.string :currency
      t.string :description
      t.float :balance,       default: 0.0
      t.float :total_credit,  default: 0.0
      t.float :total_debit,   default: 0.0

      t.belongs_to :user

      t.timestamps
    end
  end
end
