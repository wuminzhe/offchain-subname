class CreateReservedSubnames < ActiveRecord::Migration[7.2]
  def change
    create_table :reserved_subnames do |t|
      t.integer :minting_config_id
      t.string :subname
      t.boolean :mintable
      t.decimal :minting_price

      t.timestamps
    end

    add_index :reserved_subnames, [:minting_config_id, :subname], unique: true
  end
end
