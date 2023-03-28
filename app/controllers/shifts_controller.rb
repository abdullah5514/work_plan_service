class ShiftsController < ApplicationController
  def create
    worker = Worker.find(params[:worker_id])
    shift = worker.shifts.new(shift_params)

    if shift.save
      render json: shift, status: :created
    else
      render json: shift.errors, status: :unprocessable_entity
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time)
  end
end
