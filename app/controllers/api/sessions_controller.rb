class Api::SessionsController < ActionController::API

  def create
    puts params
    render json: { status: :ok }
  end

end
