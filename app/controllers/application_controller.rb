class ApplicationController < ActionController::API

  def record_not_found
    render json: { error: 'Record not found' }, status: 404
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def authorise_user_access
    unless @current_user.admin?
      return render json: { error: 'Permission denied!' }, status: 401
    end
  end

end
