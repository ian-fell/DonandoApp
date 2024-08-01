class MoviesController < ApplicationController

  before_action :set_class
  include HTTParty
  include MoviesHelper

  def index
  end

  def show_all_movies
    response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/movies")
    if response.success?
      data = response.parsed_response
      if params[:sort] == "T"
        @data = data.sort
      else
        @data = data
      end
    else
      @data = { error: "No se pudo obtener la información de la API" }
    end
  end

  def show_all_directors
    response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/directors")
    if response.success?
      data = response.parsed_response
      if params[:sort] == "T"
        @data = data.sort
      else
        @data = data
      end
    else
      @data = { error: "No se pudo obtener la información de la API" }
    end
  end

  def show_longest
    longest = 0
    wow_number = 0
    movie_name = ""
    director_name = ""
    poster = ""
    response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/movies")
    if response.success?
      @data = response.parsed_response
      @data.each do |movie|
        encoded_movie = URI.encode_www_form_component(movie)
        movie_response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/random?movie=#{encoded_movie}")
        if movie_response.success?
          movie_data = movie_response.parsed_response
          movie_time = movie_data[0]["movie_duration"]
          tiempo = movie_duration(movie_time)
          if tiempo > longest
            longest = tiempo
            wow_number = movie_data[0]["total_wows_in_movie"]
            movie_name = movie
            director_name = movie_data[0]["director"]
            poster = movie_data[0]["poster"]
          end
        else
          @data = { error: "No se pudo obtener la información de la API" }
        end
      end
      @time = time_formatter(longest)
      @wows = wow_number
      @movie = movie_name
      @director = director_name
      @image = poster
    else
      @data = { error: "No se pudo obtener la información de la API" }
    end
  end

  def show_first_last
    response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/ordered/0-9999")
    if response.success?
      @data = response.parsed_response
      @wows = [@data.first, @data.last]
      @last = @data.length
    else
      @data = { error: "No se pudo obtener la información de la API" }
    end
  end

  def show_median
    response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/ordered/0-9999")
    if response.success?
      @data = response.parsed_response
      len = @data.length
      if len % 2 == 0
        @wows = [[@data[(len / 2) - 1], len / 2], [@data[len / 2], (len / 2) + 1]]
      else
        @wows = [[@data[len / 2], (len + 1) / 2]]
      end
    else
      @data = { error: "No se pudo obtener la información de la API" }
    end
  end

  def show_most_wows
    response = HTTParty.get("https://owen-wilson-wow-api.onrender.com/wows/ordered/0-9999")
    if response.success?
      @data = response.parsed_response
      most_wows = 0
      @data.each do |wow|
        if wow["total_wows_in_movie"] > most_wows
          most_wows = wow["total_wows_in_movie"]
        end
      end
      movies = []
      @data.each do |wow|
        if wow["total_wows_in_movie"] == most_wows
          movies << wow unless wow["current_wow_in_movie"] > 1
        end
      end
      @wows = most_wows
      @movies = movies
    else
      @data = { error: "No se pudo obtener la información de la API" }
    end
  end

  def set_class
    @class = "rounded-md m-5 bg-orange-400/80 px-5 py-2 text-semibold border-black border-2 text-lg hover:opacity-50"
  end
end
