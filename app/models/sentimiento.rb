class Sentimiento < ActiveRecord::Base
  validates :sentimiento, :presence > true
end
