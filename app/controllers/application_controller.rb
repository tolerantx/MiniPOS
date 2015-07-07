class ApplicationController < ActionController::Base
  require 'csv'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!

  protect_from_forgery with: :exception

  layout :select_layout

  def select_layout
    devise_controller? ? "login" : "application"
  end
end
