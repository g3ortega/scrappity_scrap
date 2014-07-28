class AddTopicsToArticulos < ActiveRecord::Migration
  def change
    add_column :articulos, :topics, :hstore, array: true
  end
end
