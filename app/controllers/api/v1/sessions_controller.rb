class Api::V1::SessionsController < Api::ApplicationController

  def create
    if user = User.authenticate(params[:email], params[:password])
      token = user.encode
      json_string = { token: token }
      render json: json_string
    else
      head :unauthorized
    end
  end
end
