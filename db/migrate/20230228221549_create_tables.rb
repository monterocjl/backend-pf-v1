class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :name
      t.string :description
      t.integer :users_access, array: true, default: []
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
