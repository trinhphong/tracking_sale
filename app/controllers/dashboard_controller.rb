class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tasks = Task.where(date: Date.today)
  end
end
