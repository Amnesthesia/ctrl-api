class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.text :uuid
      t.references :control, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
