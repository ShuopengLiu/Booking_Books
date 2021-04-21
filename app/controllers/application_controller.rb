class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :cart, :subtotal, :set_province_if_nil

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :province_id, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :province_id, :password, :current_password)
    end
  end

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

  def subtotal
    subtotal = 0
    ids = session[:shopping_cart].keys

    ids.each do |id|
      subtotal += Book.find(id).price * session[:shopping_cart][id]
    end

    subtotal
  end

  def set_province_if_nil
    redirect_to edit_user_registration_path if current_user.province_id.nil?
  end
end
