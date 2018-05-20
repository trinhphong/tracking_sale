class Api::SessionsController < ActionController::API

  before_filter :ensure_params_exist

  def create
    resource = User.find_for_database_authentication(:email=>params[:userName])
    if resource.valid_password?(params[:password])
      sign_in resource
      render json: { status: :ok, userName: resource.email }
      return
    end
    invalid_login_attempt
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
