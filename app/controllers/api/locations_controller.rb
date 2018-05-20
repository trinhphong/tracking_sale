class Api::LocationsController < ActionController::API

  def check_in
    user = User.find_for_database_authentication(email: params[:username])
    task = Task.find_by(user_id: user.id, date: Date.today)
    outlets = task.outlets

    radius = 0.5
    center_point = [params[:lat], params[:long]]
    in_circle = false
    outlets.each do |outlet|
      outlet_point = [outlet.latitude, outlet.longitude]
      in_circle = Geocoder::Calculations.distance_between(center_point, outlet_point) < radius

      if in_circle
        taskoutlet = Taskoutlet.find_by(task_id: task.id, outlet_id: outlet.id)
        taskoutlet.update_columns(check_in: true)
      end
      break if in_circle
    end

    render json: {status: :ok, check_in: in_circle, outlets: outlets}
  end

end
