class Api::V1::DogCaresController < Api::ApplicationController
  include Api::V1::UserAuthenticator

  before_action :authenticate!

  def show
    json_string = current_user.dog.dog_cares.all
    render json: json_string
  end
end
