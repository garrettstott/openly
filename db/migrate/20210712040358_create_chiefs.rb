class CreateChiefs < ActiveRecord::Migration[6.1]
  def change
    create_table :chiefs do |t|
      t.belongs_to :company, null: false, foreign_key: true

      t.integer :created_by, null: false, index: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :title, null: false
      t.boolean :current, null: false, default: true

      t.boolean :approved, null: false, default: false
      t.boolean :denied, null: false, default: false

      t.timestamps
    end
  end
end
