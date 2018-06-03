class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { message: exception.message, params: [exception.param] }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.html { render file: "errors/404", status: :not_found }
      format.json { render json: { message: exception.message }, status: :not_found }
    end
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    respond_to do |format|
      format.html { flash.notice = exception.message; redirect_to request.referrer }
      format.json { render json: { message: exception.message }, status: :bad_request }
    end
  end

  before_action :set_locale
  before_action :verify_login

  def set_locale
    session[:locale] = params[:locale] || I18n.default_locale
    I18n.locale = session[:locale]
  end

  def default_url_options
    { locale: session[:locale] }
  end

  def verify_login
    redirect_to root_path unless session[:user_id].present?
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
