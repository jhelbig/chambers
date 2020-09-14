class CreateChambersChamberKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :chambers_chamber_keys do |t|
      t.string :chamber_uuid, null: false
      t.text :public, null: false
      t.timestamps
    end
    add_index :chambers_chamber_keys, :chamber_uuid, unique: true
  end
end
