class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product added!"
      redirect_to product_path(@product)
    else
      flash[:error] = "Action failed!"
      render 'new'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :img_url, :price)
  end
end
