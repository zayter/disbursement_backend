class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :merchant, null: false  
      t.references :shopper, null: false
      t.float :amount, null: false  
      t.string :aasm_state, null: false
      t.string :completed_at
      t.timestamps
    end
  end
end
