class CreateCertificationsEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :certifications_employees do |t|
      t.references :certification, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
