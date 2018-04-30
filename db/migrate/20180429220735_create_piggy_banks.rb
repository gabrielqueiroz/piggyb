class CreatePiggyBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :piggy_banks do |t|
      t.string :name
      t.string :currency
      t.string :description
      t.integer :balance
      t.integer :total_credit
      t.integer :total_debit

      t.belongs_to :user

      t.timestamps
    end
  end
end
