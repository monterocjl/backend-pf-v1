class CreateOperations < ActiveRecord::Migration[7.0]
  def change
    create_table :operations do |t|
      t.decimal :import, precision: 10, scale: 2
      t.text :description
      t.text :attached_url
      t.date :operation_date
      t.references :user, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.references :operation_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
