class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from InvalidParamsException do |exception|
    render json: { error: exception.to_s }, status: 400
  end
end
