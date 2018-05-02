class MovementsController < ApplicationController

  def create
    params.require(:piggy_banks_movement).permit!

    @movement = Movement.new(params[:piggy_banks_movement])
    @movement.piggy_bank_id = params[:piggy_bank_id]
    @movement.save

    redirect_to request.referrer
  end

  def show
    @piggy_bank = PiggyBank.find_by!(user_id: current_user.id, id: params[:piggy_bank_id])
    @movements = Movement.where(piggy_bank_id: params[:piggy_bank_id]).order(updated_at: :desc)

    respond_to do |format|
      format.html { }
      format.json { render json: { piggy_bank: @piggy_bank, movements: @movements }, except: :user_id, status: :ok }
    end
  end

  def destroy
    @movement = Movement.joins(:piggy_bank).find_by!('piggy_banks.id': params[:piggy_bank_id], 'piggy_banks.user': current_user.id, 'movements.id': params[:movement_id])
    @movement.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { render json: "Movement deleted", status: :ok }
    end
  end

end
