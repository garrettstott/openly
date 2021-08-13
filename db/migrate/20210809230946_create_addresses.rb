class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :addressable_id, index: true, null: false
      t.string :addressable_type, index: true, null: false

      t.string :line1
      t.string :line2
      t.string :city, null: false
      t.string :region, null: false
      t.string :country, null: false
      t.string :postal_code, null: false

      t.timestamps
    end
  end
end
