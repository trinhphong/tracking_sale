class Api::SessionsController < ActionController::API

  before_filter :ensure_params_exist, only: [:create]

  def create
    resource = User.find_for_database_authentication(:email=>params[:userName])
    if resource.valid_password?(params[:password])
      sign_in resource
      render json: { status: :ok, userName: resource.email }
      return
    end
    invalid_login_attempt
  end

  def info_staff
    staff = User.find_by(email: params[:email])

    staff_repsonse = {
      email: staff.email,
      phone_number: staff.phone_number
    }

    tasks = Task.where(user_id: staff.id, date: Date.today)
    products = tasks.map(&:product)

    response = []

    tasks.each do |task|
      response << {
        task_id: task.id,
        product_id: task.product.id,
        name: task.product.name,
        img_url: task.product.img_url,
        price: task.product.price,
        quantity: task.quantity,
        actual_quantity: task.actual_quantity
      }
    end

    render json: { status: :ok, staff: staff_repsonse, products: response }
  end

  def ensure_params_exist
    return unless params[:userName].blank? || params[:password].blank?
    render :json=>{success: false, message: "missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {success: false, :message=>"Error with your login or password"}, :status=>401
  end

end
