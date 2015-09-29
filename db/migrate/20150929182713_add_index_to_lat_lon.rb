class AddIndexToLatLon < ActiveRecord::Migration
  def change
    add_index :nodes, :x
    add_index :nodes, :y
    add_index :nodes, :name
  end
end
