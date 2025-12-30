class CreateProjectAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :project_assignments do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.date :assigned_date
      t.date :end_date
      t.integer :hours_allocated

      t.timestamps
    end
  end
end
