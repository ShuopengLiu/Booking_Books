class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :initialize_session
  helper_method :cart

  private

  def initialize_session
    # Create a shopping cart in form of hash
    session[:shopping_cart] ||= {}
  end

  def cart
    # .find will take in a single value OR an array of values
    # with an array, it will bring back a collection of objects based on those PK id's
    Book.find(session[:shopping_cart].keys)
  end

  # def increase(id)
  #   session[:shopping_cart][id.to_s] += 1
  # end

  # def decrease(id)
  #   if session[:shopping_cart][id] == 1
  #     session[:shopping_cart].delete(id)
  #   else
  #     session[:shopping_cart][id] -= 1
  #   end
  # end
end
