class CreateSubnames < ActiveRecord::Migration[7.2]
  def change
    create_table :subnames do |t|
      t.string :name
      t.references :domain, null: false, foreign_key: true
      t.string :full_name

      t.timestamps
    end
    add_index :subnames, :name
  end
end
