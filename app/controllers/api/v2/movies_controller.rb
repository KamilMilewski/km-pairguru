class Api::V2::MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @genre = @movie.genre
    render json: {
      id: @movie.id,
      title: @movie.title,
      description: @movie.description,
      genre: {
        id: @genre.id,
        name: @genre.name,
        total_in_genre: @genre.movies.count
      }
    }
  end

  def index
    movie_json = []
    @movies = Movie.all.each do |movie|
      genre = movie.genre
      movie_hash = {
        id: movie.id,
        title: movie.title,
        genre: {
          id: genre.id,
          name: genre.name,
          total_in_genre: genre.movies.count
        }
      }
      movie_json.push(movie_hash)
    end
    render json: movie_json
  end
end
