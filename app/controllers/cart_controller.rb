class CartController < ApplicationController
  def create
    # Add param[:id] to the cart
    # logger.debug("Adding #{params[:id]} to the cart!")
    id = params[:id].to_i
    if session[:shopping_cart].include?(id)
      session[:id] += 1
    else
      session[:shopping_cart] << id
      session[:id] = 1
    end

    book = Book.find(id)
    flash[:notice] = "+ #{book.title} added to cart."
    redirect_to root_path
  end

  def destroy
    # remove param[:id] from cart
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    book = Book.find(id)
    flash[:notice] = "- #{book.title} removed from cart."
    redirect_to root_path
  end
end
