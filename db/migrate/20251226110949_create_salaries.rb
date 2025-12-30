class CreateSalaries < ActiveRecord::Migration[8.1]
  def change
    create_table :salaries do |t|
      t.references :employee, null: false, foreign_key: true
      t.decimal :amount
      t.date :effective_from
      t.date :effective_to
      t.string :currency

      t.timestamps
    end
  end
end
