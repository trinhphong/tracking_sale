class TasksController < ApplicationController
  before_action :authenticate_admin!

  def index
    @date  = Date.parse(params[:date]) rescue Date.today
    @tasks = Task.where(date: params[:date] || Date.today)
  end

  def new
    @task = Task.new
    @staffs = User.all
    @outlets = Outlet.all

  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = "Task added!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
    outlet_ids = Outletproduct.where(product_id: @task.product_id).map(&:outlet_id)
    @outlets = Outlet.where(id: outlet_ids)
  end

  private

  def task_params
    params.require(:task).permit(:date, :user_id, :admin_id, :note, :latitude, :longitude, :quantity, :product_id)
  end
end

