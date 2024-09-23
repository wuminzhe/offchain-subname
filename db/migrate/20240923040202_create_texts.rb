class CreateTexts < ActiveRecord::Migration[7.2]
  def change
    create_table :texts do |t|
      t.string :key
      t.text :value
      t.references :subname, null: false, foreign_key: true

      t.timestamps
    end
  end
end
