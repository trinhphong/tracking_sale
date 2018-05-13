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
    @task_outlet = @task.taskoutlets.build
  end

  def create
    @task = Task.new(task_params)

    params[:task][:outlet_ids].each do |outlet, idx|
      if !outlet.empty?
        @task.taskoutlets.build(outlet_id: outlet, priority: idx)
      end
    end
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
    params.require(:task).permit(:date, :user_id, :admin_id, :note, :latitude, :longitude, :expect_sale)
  end
end

