class UsersController < ApplicationController

  rescue_from(ActionController::ParameterMissing) do |exception|
    render json: { message: exception.message, params: [exception.param] }, status: :bad_request
  end

  def create
    params.require(:user).permit!

    @user = User.new(params[:user])
    @user.save

    respond_to do |format|
      format.html do
        session[:user_id] = @user.id
        redirect_to '/piggy_banks'
      end
      format.json { render json: @user, except: :password_digest, status: 201 }
    end
  end

end
