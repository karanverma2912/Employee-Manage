class CreateCertifications < ActiveRecord::Migration[8.1]
  def change
    create_table :certifications do |t|
      t.string :name
      t.string :issuing_body
      t.text :description
      t.date :valid_from
      t.date :valid_to

      t.timestamps
    end
  end
end
