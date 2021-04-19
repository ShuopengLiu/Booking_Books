class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page])
  end

  # GET /books/:id
  def show
    @book = Book.find(params[:id])
  end
end
