class AddTopicsToArticulos < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :articulos, :topics, :hstore, array: true
  end
end
