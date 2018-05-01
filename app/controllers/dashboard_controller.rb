class DashboardController < ApplicationController
  def index
    @tasks = Task.where(date: Date.today)
  end
end
