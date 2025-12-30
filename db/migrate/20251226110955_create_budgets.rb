class CreateBudgets < ActiveRecord::Migration[8.1]
  def change
    create_table :budgets do |t|
      t.references :department, null: false, foreign_key: true
      t.decimal :allocated_amount
      t.decimal :spent_amount
      t.integer :fiscal_year

      t.timestamps
    end
  end
end
