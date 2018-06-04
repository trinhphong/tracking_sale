class Api::SaleController < ActionController::API

  def save_sale
    user = User.find_for_database_authentication(email: params[:userName])
    tasks = Task.where(user_id: user.id, date: Date.today)
    products = tasks.map(&:product)

    response = []

    tasks.each do |task|
      response << {
        task_id: task.id,
        product_id: task.product.id,
        name: task.product.name,
        img_url: task.product.img_url,
        price: task.product.price,
        quanlity: task.quantity
      }
    end
    render json: { status: :ok, products: response }
  end

  def sell
    task = Task.find(params[:IdTask])
    quantity = params[:quantity]
    current_quantity = task.quantity
    new_quantity = current_quantity + quantity

    task.update_columns(actual_quantity: new_quantity)

    render json: { status: :ok }
  end

  def get_outlets
    product = Product.find(params[:IdProducts])
    outlets = product.outlets
    render json: { status: :ok, outlets: outlets }
  end
end
