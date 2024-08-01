module MoviesHelper

  def movie_duration(duration_string)
    horas, minutos, segundos = duration_string.split(':')
    horas = horas.to_i
    minutos = minutos.to_i
    segundos = segundos.to_i
    tiempo = segundos + (minutos * 60) + (horas * 3600)
    tiempo
  end

  def time_formatter(segundos)
    horas = segundos / 3600
    minutos = (segundos % 3600) / 60
    segundos = segundos % 60

    "#{horas} horas, #{minutos} minutos, #{segundos} segundos"
  end

end
