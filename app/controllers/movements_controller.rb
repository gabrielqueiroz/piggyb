class MovementsController < ApplicationController

  before_action :verify_authenticity

  def create
    params.require(:piggy_banks_movement).permit!

    @movement = Movement.new(params[:piggy_banks_movement])
    @movement.piggy_bank_id = params[:piggy_bank_id]
    @movement.save

    redirect_to piggy_banks_movements_path
  end

  def show
    @piggy_bank = PiggyBank.find(params[:piggy_bank_id])
    @movements = Movement.where(piggy_bank_id: params[:piggy_bank_id]).order(updated_at: :desc)

    respond_to do |format|
      format.html { }
      format.json { render json: { piggy_bank: @piggy_bank, movements: @movements }, except: :user_id, status: 200 }
    end
  end

  private
  def verify_authenticity
    piggy_bank = PiggyBank.find(params[:piggy_bank_id])
    piggy_bank.present? && piggy_bank.user_id == session[:user_id]
  end
end
