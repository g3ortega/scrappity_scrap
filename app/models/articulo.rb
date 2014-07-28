class Articulo < ActiveRecord::Base

  validates :titulo, presence: true, uniqueness: 'true'
  validates :clasificacion, presence: true
  validates :fecha, presence: true

  scope :created_between, lambda {|start_date, end_date| where("fecha >= ? AND fecha <= ?", start_date, end_date )}


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
