class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.text :message
      t.integer :style, null: false

      t.integer :created_by_id, null: false, index: true
      t.integer :noteable_id, index: true
      t.string :noteable_type, index: true

      t.timestamps
    end
  end
end
