class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :cif, null: false, index: { unique: true }
      t.references :user, null: false
      t.timestamps
    end
  end
end
