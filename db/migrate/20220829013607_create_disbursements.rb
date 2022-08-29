class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false 
      t.integer :week, null: false  
      t.integer :year, null: false         
      t.float :amount, null: false  
      t.timestamps
    end
  end
end
