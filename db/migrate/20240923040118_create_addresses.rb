class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :address
      t.integer :coin_type
      t.references :subname, null: false, foreign_key: true

      t.timestamps
    end
  end
end
