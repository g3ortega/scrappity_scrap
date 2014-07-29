namespace :retrieval do

  fecha_inicial = Date.new(2014, 05, 01)


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







end
