class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :postal_code, nill: false
      t.integer :prefecture_id, nill: false
      t.integer :city, nill: false
      t.integer :address, nill: false
      t.integer :biilding, nill: false
      t.integer :phone_number, nill: false
      t.timestamps
    end
  end
end
