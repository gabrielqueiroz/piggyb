class UsersController < ApplicationController

  skip_before_action :verify_login

  def create
    params.require(:user).permit!

    user = User.new(params[:user])
    user.save!

    respond_to do |format|
      format.html do
        session[:user_id] = user.id
        redirect_to piggy_banks_path
      end
      format.json { render json: user, except: [:id, :password_digest], status: :created }
    end
  end

end
