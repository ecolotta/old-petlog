class Api::V1::UsersController < Api::ApplicationController
  include Api::V1::UserAuthenticator
  before_action :authenticate_api_v1_user!, only: %i[token]

  def update; end

  def destroy; end

  def me
    json_string = []
    json_string << current_user
    json_string << current_user.dog if current_user.dog.present?
    render json: json_string
  end

  def token
    if current_api_v1_user
      token = current_api_v1_user.create_tokens
      json_string = { token: token }
      render json: json_string
    else
      head :unauthorized
    end
  end

  protected

  def authenticate_api_v1_user! #エラー時の反応を変更
    if api_v1_user_signed_in?
      super
    else
      render json: { status: :error, message: :unauthorized }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
