class GenresController < ApplicationController
  # GET /
  # GET /genres
  def index
    @genres = Genre.all
  end

  # GET /genres/:id
  def show
    @genre = Genre.find(params[:id])
  end
end
