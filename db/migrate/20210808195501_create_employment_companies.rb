class CreateEmploymentCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :employment_companies do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true

      t.boolean :current, null: false, default: true
      t.date :start_date, null: false
      t.date :end_date
      t.string :job_title, null: false
      t.integer :salary

      t.timestamps
    end
  end
end
