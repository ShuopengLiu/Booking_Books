class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :initialize_session
  helper_method :cart, :quantity

  private

  def initialize_session
    session[:shopping_cart] ||= []
  end

  def cart
    # .find will take in a single value OR an array of values
    # with an array, it will bring back a collection of objects based on those PK id's
    Book.find(session[:shopping_cart])
  end

  def quantity
    session[:id]
  end
end
