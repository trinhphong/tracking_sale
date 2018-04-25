class TasksController < ApplicationController
  before_action :authenticate_admin!

  def new
    @task = Task.new
    @staffs = User.all
  end

  def create
  end
end
