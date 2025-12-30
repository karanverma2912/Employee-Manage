class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :job_title
      t.date :hire_date
      t.references :department, null: false, foreign_key: true
      t.references :manager, foreign_key: { to_table: :employees }
      t.boolean :is_active

      t.timestamps
    end
  end
end
