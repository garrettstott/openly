class CreateJobListings < ActiveRecord::Migration[6.1]
  def change
    create_table :job_listings do |t|
      t.belongs_to :company, null: false, foreign_key: true

      t.string :job_title
      t.string :salary
      t.text :description
      t.integer :job_type

      t.timestamps
    end
  end
end
