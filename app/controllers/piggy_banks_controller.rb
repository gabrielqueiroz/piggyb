class PiggyBanksController < ApplicationController

  def index
    @piggy_banks = PiggyBank.where(user_id: current_user.id)

    respond_to do |format|
      format.html
      format.json { render json: @piggy_banks, except: :user_id, status: 200 }
    end
  end

  def create
    params.require(:piggy_bank).permit!

    @piggy_bank = PiggyBank.new(params[:piggy_bank])
    @piggy_bank.user_id = session[:user_id]
    @piggy_bank.total_credit = @piggy_bank.balance
    @piggy_bank.save

    respond_to do |format|
      format.html { redirect_to '/piggy_banks' }
      format.json { render json: @piggy_bank, except: :user_id, status: 201 }
    end
  end

  def destroy
    @piggy_bank = PiggyBank.find(params[:id])
    @piggy_bank.destroy

    redirect_to '/piggy_banks'
  end
end
