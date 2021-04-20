class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page])
  end

  # GET /books/:id
  def show
    @book = Book.find(params[:id])
  end

  def search
    @key_word = params[:keyword]
    @category_id = params[:name].to_i

    logger.debug("LSP*****Search Key word:#{@key_word}")
    logger.debug("LSP*****Category ID:#{@category_id}")

    @category_name = Genre.find(params[:name]).name

    logger.debug("LSP*****Category Name:#{@category_name}")

    @books = if @key_word.blank?
               if @category_name == "all"
                 Book.all.page(params[:page])
               else
                 Book.where("genre_id == :cat", cat: @category_id)
                     .page(params[:page])
               end
             elsif @category_name == "all"
               Book.where("title LIKE ? OR description LIKE ?", "%#{@key_word}%", "%#{@key_word}%")
                   .page(params[:page])
             else
               Book.where("title LIKE ? OR description LIKE ?", "%#{@key_word}%", "%#{@key_word}%")
                   .where("genre_id == :cat", cat: @category_id)
                   .page(params[:page])
             end
  end
end
