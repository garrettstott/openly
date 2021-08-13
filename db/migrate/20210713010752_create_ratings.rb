class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.belongs_to :review, null: false, foreign_key: true
      t.integer :style, null: false
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
