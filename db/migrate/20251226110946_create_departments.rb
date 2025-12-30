class CreateDepartments < ActiveRecord::Migration[8.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.decimal :budget_allocation

      t.timestamps
    end
  end
end
