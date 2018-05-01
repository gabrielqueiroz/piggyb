class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { message: exception.message, params: [exception.param] }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { message: exception.message }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { message: exception.message }, status: :bad_request
  end

  def current_user
    case request.format
    when Mime[:json]
      @user ||= authenticate_user
    else
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  private
  def authenticate_user
    authenticate_with_http_basic do |email, password|
      user = User.find_by!(email: email)
      return user if user.present? && user.authenticate(password)
    end
  end
end
