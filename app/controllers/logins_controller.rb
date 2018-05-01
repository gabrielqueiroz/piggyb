class LoginsController < ApplicationController

  def index
  end

  def create
    user = User.find_by(email: params[:login][:email])
    if user.present? && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      redirect_to '/piggy_banks'
    else
      flash.notice = "Email or Password invalid. Please try again"
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
