class Api::V1::SessionsController < Api::ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      token = user.encode
      json_string = { token: token }
      render json: json_string
    else
      head :unauthorized
    end
  end
end
