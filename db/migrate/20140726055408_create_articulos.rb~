class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.string :titulo , :null => false
      t.string :abstracto
      t.string :contenido
      t.string :clasificacion , :null => false
      t.datetime :fecha , :null => false
      t.string :url

      t.timestamps
    end
  end
end
