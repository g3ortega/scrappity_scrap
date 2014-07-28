class ChangeTypeOfDateFromStringToText < ActiveRecord::Migration
  def up
    change_column :articulos, :contenido, :text, :limit => nil
    change_column :articulos, :abstracto, :text, :limit => nil
  end

  def down
    change_column :articulos, :contenido, :string
    change_column :articulos, :abstracto, :string
  end
end
