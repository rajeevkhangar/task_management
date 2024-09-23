class RegistrationsController < ApplicationController


  def create
    begin
      user = User.create!(user_params)
      render json: user, stauts: 201
    rescue Exception => e
      render json: { error: e }, status: 401
    end
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :role)
  end
end
