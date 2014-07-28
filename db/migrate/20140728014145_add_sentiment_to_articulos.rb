class AddSentimentToArticulos < ActiveRecord::Migration
  def change
    add_column :articulos, :sentimiento, :string
  end
end
