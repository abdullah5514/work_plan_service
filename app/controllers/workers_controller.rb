class WorkersController < ApplicationController
  def index
    @workers = Worker.all
    render json: @workers
  end

  def create
    @worker = Worker.new(worker_params)
    if @worker.save
      render json: @worker, status: :created
    else
      render json: @worker.errors, status: :unprocessable_entity
    end
  end

  private

  def worker_params
    params.require(:worker).permit(:name)
  end
end
