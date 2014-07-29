class Articulo < ActiveRecord::Base

  validates :titulo, presence: true, uniqueness: 'true'
  validates :clasificacion, presence: true
  validates :fecha, presence: true

  VALUES_SENTIMENT = ['N', 'N+', 'P', 'P+']

  scope :created_between, lambda {|start_date, end_date| where("fecha >= ? AND fecha <= ?", start_date, end_date )}



  def self.get_topics_data(terminos)
    init_date = Articulo.first.fecha
    finish_date = Articulo.last.fecha

    resultado = {}

    (init_date..finish_date).step(7) do |date|
        if resultado[date.to_s].nil?
          resultado[date.to_s] = {}
        end

      terminos.each do |term|
        resultado[date.to_s][term] = Articulo.created_between(date, date + 7 ).where("data ? '#{term}'").count
      end

    end

    resultado

  end


  def self.get_sentiment_data(terminos)
    init_date = Articulo.first.fecha
    finish_date = Articulo.last.fecha

    resultado = {}

    (init_date..finish_date).step(7) do |date|

      if resultado[date.to_s].nil?
        resultado[date.to_s] = {}
      end

      terminos.each do |term|
        if resultado[date.to_s][term].nil?
          resultado[date.to_s][term] = {}
        end

        VALUES_SENTIMENT.each do |value|
          resultado[date.to_s][term][value] = Articulo.created_between(date, date+7).where("data ? '#{term}'").pluck(:sentimiento).count("#{value}")
        end
      end

    end

    resultado

  end



  def self.save_general_data(init_date)

    (init_date..Time.now).each do |date|

      doc = fetch_and_parse("http://www.elnuevodiario.com.ni/archivo.php?Year=#{date.year}&Month=#{date.month}&Day=#{date.day}")
      doc.css(".news").each do |section|
           section.css("li").each do |new|
               titulo = new.css("h1").inner_text
               puts "Guardando articulo #{titulo}"
               abstracto = new.xpath('text()').text.strip
               clasificacion = new.css("h3").inner_text
               subtitulo = new.css("h2").inner_text
               fecha = date
               url = new.css("h1").css("a").xpath('@href').text

              Articulo.create(titulo: titulo, abstracto: abstracto, contenido: nil, clasificacion: clasificacion, subtitulo: subtitulo, fecha: date, url: url)
           end
      end
    end

  end

  def self.fetch_and_parse(url)
    Nokogiri::HTML(RestClient.get(url))
  end






end
