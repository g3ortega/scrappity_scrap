namespace :retrieval do

  fecha_inicial = Date.new(2014, 05, 01)
  fecha_articulos_sentimiento = Date.new(2014, 07, 01)


  desc "Obtener los datos (exepto el contenido) de los articulos publicados desde la fecha inicial hasta la actual"
  task retreive: :environment do

    if Articulo.where(fecha: fecha_inicial).empty?
      Articulo.save_general_data(fecha_inicial)
    elsif Articulo.last.fecha < Date.today
      current_date = Articulo.last.fecha
      next_day_date = current_date + 1
      Articulo.save_general_data(next_day_date)
    else
      puts "Todo está actualizado"
    end

  end

  desc "Obtener contenido para articulos del último mes"
  task get_content: :environment do

    Articulo.created_between(fecha_articulos_sentimiento, Articulo.last.fecha).each do |articulo|
      puts "Actualizando: #{articulo.titulo}"
      if articulo.contenido.nil?
        doc = Articulo.fetch_and_parse(articulo.url)
        contenido = doc.css(".texto").text.gsub(/\r\n/,' ').split[0..500].join(" ")
        articulo.update(contenido: contenido )
      else
        puts "Actualizado"
      end

    end

  end






end
