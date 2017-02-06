class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  expose_decorated(:movies) { Movie.all }
  expose(:movie)

  def show
    if m = Tmdb::Search.movie(movie.title)
      @rating = m.results.first.vote_average
      poster_path = m.results.first.poster_path
      @poster_url = "http://image.tmdb.org/t/p/w185//#{poster_path}"
      @overview = m.results.first.overview
    else
      @rating = 'no data'
      @poster_url = ''
      @overview = 'no data'
    end
  end

  def send_info
    MovieInfoMailer.send_info(current_user, movie).deliver_now
    redirect_to :back, notice: 'Email sent with movie info'
  end

  def export
    file_path = 'tmp/movies.csv'
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: 'Movies exported'
  end
end
