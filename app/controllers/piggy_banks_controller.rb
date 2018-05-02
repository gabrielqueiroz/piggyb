class PiggyBanksController < ApplicationController
  def index
    @piggy_banks = PiggyBank.where(user_id: current_user.id)
    @summary = Summary.build_from_piggy_banks(@piggy_banks)

    respond_to do |format|
      format.html
      format.json { render json: { summary: @summary, piggy_banks: @piggy_banks }, except: [:id, :user_id], status: :ok }
    end
  end

  def create
    params.require(:piggy_bank).permit!

    @piggy_bank = PiggyBank.new(params[:piggy_bank])
    @piggy_bank.user_id = current_user.id
    @piggy_bank.total_credit = @piggy_bank.balance
    @piggy_bank.save

    respond_to do |format|
      format.html { redirect_to piggy_banks_path }
      format.json { render json: @piggy_bank, except: [:id, :user_id], status: :created }
    end
  end

  def edit
    @piggy_bank = PiggyBank.find(params[:id])
  end

  def update
    params.require(:piggy_bank).permit!

    @piggy_bank = PiggyBank.update(params[:id], params[:piggy_bank])

    respond_to do |format|
      format.html { redirect_to piggy_banks_path }
      format.json { render json: @piggy_bank, except: [:id, :user_id], status: :ok }
    end
  end

  def destroy
    @piggy_bank = PiggyBank.find(params[:id])
    @piggy_bank.destroy

    redirect_to piggy_banks_path
  end

end
