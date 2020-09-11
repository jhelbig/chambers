class CreateChambersChambers < ActiveRecord::Migration[6.0]
  def change
    create_table :chambers_chambers do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :host, null: false
      t.boolean :active, null: false, default: false
      t.integer :level, null: false, default: 1
      t.timestamps
    end
    add_index :chambers_chambers, :uuid
    add_index :chambers_chambers, [:name, :host], unique: true
  end
end