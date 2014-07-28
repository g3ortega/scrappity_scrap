namespace :analyze do

  fecha_inicial = Date.new(2014, 05, 01)
  fecha_articulos_sentimiento = Date.new(2014, 07, 23)
  t = Textalytics::Client.new

  desc "Analizar sentimiento"
  task sentiment: :environment do
    Articulo.created_between(fecha_articulos_sentimiento, Articulo.last.fecha).each do |articulo|
      puts "Analizando: #{articulo.titulo}"
      if articulo.sentimiento.nil? and articulo.contenido.present? and articulo.contenido.split.size < 800
        sentiment = t.sentiment(txt: articulo.contenido, model: 'es-general')
        sentimiento = sentiment.score_tag
        puts sentiment.all["status"]["remaining_credits"]
        articulo.update(sentimiento: sentimiento )
      else
        puts "Actualizado"
      end

    end

  end

  end

