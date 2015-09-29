class CreateControls < ActiveRecord::Migration
  def change
    create_table :controls do |t|
      t.string :name
      t.references :node, index: true, foreign_key: true
      t.references :device, index: true, foreign_key: true
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
