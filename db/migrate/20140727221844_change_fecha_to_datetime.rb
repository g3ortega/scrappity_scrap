class ChangeFechaToDatetime < ActiveRecord::Migration
  def change
    change_column :articulos, :fecha, :date
  end
end
