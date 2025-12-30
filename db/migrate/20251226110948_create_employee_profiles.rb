class CreateEmployeeProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :employee_profiles do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :phone
      t.string :address
      t.string :city
      t.string :country
      t.date :date_of_birth
      t.string :blood_group

      t.timestamps
    end
  end
end
