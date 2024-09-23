class SessionsController < ApplicationController

  def create
    user = User.where(email: user_params[:email]).first

    if user.nil?
      return render json: {error: 'Invalid credentails'}, status: 401
    end

    unless user.password == user_params[:password]
      return render json: {error: 'Invalid credentails'}, status: 401
    end

    token = JsonWebToken.encode(user_id: user.id)

    time = Time.now + 24.hours.to_i
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
