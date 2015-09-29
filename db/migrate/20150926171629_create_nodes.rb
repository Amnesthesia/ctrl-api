class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.decimal :x
      t.decimal :y

      t.timestamps null: false
    end
  end
end
