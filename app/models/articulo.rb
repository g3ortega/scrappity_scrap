class Articulo < ActiveRecord::Base
  has_one :sentimiento
  validates :titulo, :presence > true
  validates :clasificacion, :presence > true
  validates :fecha, :presence > true
end
