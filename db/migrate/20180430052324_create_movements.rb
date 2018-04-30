class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.string :name
      t.string :description
      t.float  :amount, default: 0.0
      
      t.belongs_to :piggy_bank

      t.timestamps
    end
  end
end
