require 'nokogiri'
require 'rest-client'

namespace :retrieval do

  fecha_inicial = Date.new(2014, 04, 01)

  desc "TODO"
  task retreive: :environment do
    Articulo.save_general_data(fecha_inicial)
  end



end
