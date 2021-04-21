class CartController < ApplicationController
  def index
    logger.debug "***Current User***: #{current_user.id}"
    logger.debug "***Current User***: #{current_user.email}"
  end

  def create
    id = params[:id]
    if session[:shopping_cart].keys.include?(id)
      session[:shopping_cart][id] += 1
    else
      session[:shopping_cart][id] = 1
    end
    book = Book.find(id.to_i)
    flash[:notice] = "<< #{book.title} >> added to cart."
    redirect_back(fallback_location: root_path)
  end

  def destroy
    # remove param[:id] from cart
    id = params[:id]
    session[:shopping_cart].delete(id)
    book = Book.find(id.to_i)
    flash[:notice] = "<< #{book.title} >> removed from cart."
    redirect_back(fallback_location: root_path)
  end

  def update
    id = params[:id]
    if session[:shopping_cart][id] == 1
      session[:shopping_cart].delete(id)
    else
      session[:shopping_cart][id] -= 1
    end
    book = Book.find(id.to_i)
    flash[:notice] = "<< #{book.title} >> removed from cart."
    redirect_back(fallback_location: root_path)
  end
end
