namespace :analyze do

  fecha_inicial = Date.new(2014, 05, 01)
  t_sentiment = Textalytics::Client.new(sentiment: Rails.application.secrets.sentiment)
  t_topics = Textalytics::Client.new(topics: Rails.application.secrets.topics)

  desc "Analizar sentimiento"
  task sentiment: :environment do

    Articulo.created_between(fecha_inicial, Articulo.last.fecha).each do |articulo|

      puts "Analizando: #{articulo.titulo}"
      if articulo.sentimiento.nil?
        sleep 1
        sentiment = t_sentiment.sentiment(txt: articulo.abstracto, model: 'es-general')
        sentimiento = sentiment.score_tag
        articulo.update(sentimiento: sentimiento )
      else
        puts "Actualizado"
      end

    end

  end

  desc "Analizar topicos"
  task topics: :environment do

    Articulo.created_between(fecha_inicial, Articulo.last.fecha).each do |articulo|

      puts "Analizando: #{articulo.titulo}"
      if articulo.data.nil?
        sleep 2
        topics_hash = t_topics.topics(txt: articulo.abstracto, lang: 'es', model: 'es-general', tt: 'ec')
        topics = {}

        if topics_hash.all["entity_list"].any?
          topics_hash.all["entity_list"].each do |e|
            topics[e["form"]] = e["relevance"].to_i
          end
        end

        if topics_hash.all["concept_list"].any?
          topics_hash.all["concept_list"].each do |e|
            topics[e["form"]] = e["relevance"].to_i
          end
        end

        articulo.update(data: topics )
      else
        puts "Actualizado"
      end

    end

  end

  end

