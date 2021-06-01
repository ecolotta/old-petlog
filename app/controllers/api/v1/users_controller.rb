class Api::V1::UsersController < Api::ApplicationController
  include Api::V1::UserAuthenticator

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def update; end

  def destroy; end

  def me
    json_string = []
    json_string << current_user
    json_string << current_user.dog if current_user.dog.present?
    render json: json_string
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
