namespace :analyze do

  fecha_inicial = Date.new(2014, 05, 01)
  t = Textalytics::Client.new

  desc "Analizar sentimiento"
  task sentiment: :environment do

    Articulo.created_between(fecha_inicial, Articulo.last.fecha).each do |articulo|

      puts "Analizando: #{articulo.titulo}"
      if articulo.sentimiento.nil?
        sentiment = t.sentiment(txt: articulo.abstracto, model: 'es-general')
        sentimiento = sentiment.score_tag
        articulo.update(sentimiento: sentimiento )
      else
        puts "Actualizado"
      end

    end

  end

  end

