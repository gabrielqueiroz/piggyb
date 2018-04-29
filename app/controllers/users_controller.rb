class UsersController < ApplicationController

  def create
    params.require(:user).permit!

    @user = User.new(params[:user])
    @user.save

    redirect_to '/'
  end

end
