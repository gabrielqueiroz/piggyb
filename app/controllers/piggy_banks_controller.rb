class PiggyBanksController < ApplicationController

  rescue_from(ActionController::ParameterMissing) do |exception|
    render json: { message: exception.message, params: [exception.param] }, status: :bad_request
  end

  def index
    @user = User.find(session[:user_id])
    @piggy_banks = PiggyBank.where(user_id: session[:user_id])
    puts "-----> #{@piggy_banks.inspect}"
  end

  def create
    params.require(:piggy_bank).permit!

    @piggy_bank = PiggyBank.new(params[:piggy_bank])
    @piggy_bank.user_id = session[:user_id]
    @piggy_bank.save

    respond_to do |format|
      format.html { redirect_to '/piggy_banks' }
      format.json { render json: @piggy_bank, except: :password_digest, status: 201 }
    end
  end
end
