class MoviesController < ApplicationController

  before_action :set_class
  include HTTParty

  def index
  end

  def show_all_movies
    response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/movies")
    if response.success?
      @data = response.parsed_response
    else
      @data = { error: "No se pudo obtener la información de la API" }
    end
  end

  def show_all_directors
    puts "Esto es para todos los directores"
  end

  def show_longest
  end

  def show_first_last
  end

  def show_median
  end

  def set_class
    @class = "rounded-md m-5 bg-orange-400/80 px-5 py-2 text-semibold border-black border-2 text-lg hover:opacity-50"
  end
end
