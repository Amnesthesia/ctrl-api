class AddMetroToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :metro, :boolean
  end
end
