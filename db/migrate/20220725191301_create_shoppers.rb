class CreateShoppers < ActiveRecord::Migration[7.0]
  def change
    create_table :shoppers do |t|
      t.string :nif, null: false, index: { unique: true }
      t.references :user, null: false
      t.timestamps
    end

  end
end
