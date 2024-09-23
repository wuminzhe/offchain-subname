class CreateContentHashes < ActiveRecord::Migration[7.2]
  def change
    create_table :content_hashes do |t|
      t.string :content
      t.references :subname, null: false, foreign_key: true

      t.timestamps
    end
  end
end
