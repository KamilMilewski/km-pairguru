class Api::V1::MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    render json: {
      id: @movie.id,
      title: @movie.title,
      description: @movie.description
    }
  end

  def index
    @movies = Movie.all.select(:id, :title)
    render json: @movies
  end
end
