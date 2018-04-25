class TasksController < ApplicationController
  before_action :authenticate_admin!

  def new
    @task = Task.new
    @staffs = User.all
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
  end

  private

  def task_params
    params.require(:task).permit(:date, :user_id, :admin_id, :note, :latitude, :longitude)
  end
end
