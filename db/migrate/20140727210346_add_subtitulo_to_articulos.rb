class AddSubtituloToArticulos < ActiveRecord::Migration
  def change
    add_column :articulos, :subtitulo, :string
  end
end
