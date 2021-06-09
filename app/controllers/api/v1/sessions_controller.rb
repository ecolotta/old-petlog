class Api::V1::SessionsController < Api::ApplicationController
  def destroy
    sign_out
    render json: {status: :success}
  end
end
