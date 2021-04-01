class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  # GET /books/:id
  def show
    @book = Book.find(params[:id])
  end

end
