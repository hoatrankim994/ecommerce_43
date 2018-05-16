class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def current_cart
    session[:cart] ||= {}
  end
end
