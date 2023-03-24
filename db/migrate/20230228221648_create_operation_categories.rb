class CreateOperationCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :operation_categories do |t|
      t.string :name
      t.string :description
      t.integer :operation_type
      t.references :table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
