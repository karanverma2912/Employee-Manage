class CreatePerformances < ActiveRecord::Migration[8.1]
  def change
    create_table :performances do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :review_date
      t.integer :rating
      t.text :comments

      t.timestamps
    end
  end
end
