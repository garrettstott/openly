class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true
      t.belongs_to :chief, foreign_key: true

      t.text :message, null: false
      t.text :previous_message
      t.integer :thumbs, null: false, default: 0
      t.float :overall_rating, null: false, default: 0

      t.boolean :approved, null: false, default: false
      t.boolean :denied, null: false, default: false

      t.timestamps
    end
  end
end
