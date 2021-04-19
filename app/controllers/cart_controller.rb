class CartController < ApplicationController
  helper_method :subtotal, :set_province_if_nil

  def index
    logger.debug "***Current User***: #{current_user.id}"
    logger.debug "***Current User***: #{current_user.email}"
  end

  def create
    # Add param[:id] to the cart

    id = params[:id]
    logger.debug "LSP***BOOK ID***: #{id}"
    logger.debug "LSP***BOOK ID***: #{id}"
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
      # decrease
      session[:shopping_cart].delete(id)
    else
      session[:shopping_cart][id] -= 1
    end
    book = Book.find(id.to_i)
    flash[:notice] = "<< #{book.title} >> removed from cart."
    redirect_back(fallback_location: root_path)
  end

  private

  def subtotal
    subtotal = 0
    ids = session[:shopping_cart].keys

    ids.each do |id|
      subtotal += Book.find(id).price * session[:shopping_cart][id]
    end

    subtotal
  end

  def set_province_if_nil
    if current_user.province_id.nil?
      redirect_to edit_user_registration_path
    end
  end
end
