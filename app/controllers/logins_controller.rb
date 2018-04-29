class LoginsController < ApplicationController

  def index
  end

  def create
    user = User.find_by(email: params[:login][:email]).authenticate(params[:login][:password])
    if user
      session[:user_id] = user.id
    else
      flash.notice = "Email or Password invalid. Please try again"
      redirect_to '/'
    end
  end
end
