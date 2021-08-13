class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.integer :founded
      t.string :website
      t.integer :employee_count
      t.string :industry
      t.text :about
      t.integer :created_by, null: false, index: true

      t.boolean :approved, null: false, default: false
      t.boolean :denied, null: false, default: false

      t.timestamps
    end
  end
end
