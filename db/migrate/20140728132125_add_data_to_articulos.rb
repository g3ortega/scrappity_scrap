class AddDataToArticulos < ActiveRecord::Migration
  def up
    add_column :articulos, :data, :hstore
  end

  def down
    remove_column :articulos, :data
  end
end
