class CreateDomains < ActiveRecord::Migration[7.2]
  def change
    create_table :domains do |t|
      t.string :name

      t.timestamps
    end
    add_index :domains, :name, unique: true
  end
end
