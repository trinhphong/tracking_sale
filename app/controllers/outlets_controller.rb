class OutletsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @outlets = Outlet.all
  end

  def show
    @outlet = Outlet.find(params[:id])
  end

  def new
    @outlet = Outlet.new
  end

  def create
    @outlet = Outlet.new(outlet_params)
    if @outlet.save
      flash[:success] = "Oulet added!"
      redirect_to outlet_path(@outlet)
    else
      flash[:error] = "Action failed!"
      render 'new'
    end
  end

  def destroy
    @outlet = Outlet.find(params[:id])
    if @outlet.destroy
      flash[:success] = "Outlet deleted!"
    else
      flash[:error] = "Action failed!"
    end
    redirect_to outlets_path
  end

  private

  def outlet_params
    params.require(:outlet).permit(:address, :latitude, :longitude)
  end
end
