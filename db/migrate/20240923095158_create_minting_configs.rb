class CreateMintingConfigs < ActiveRecord::Migration[7.2]
  def change
    create_table :minting_configs do |t|
      t.integer :domain_id
      t.decimal :base_price
      t.text :length_prices
      t.text :type_prices
      t.boolean :free_minting

      t.timestamps
    end
  end
end
