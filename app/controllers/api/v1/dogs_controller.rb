class Api::V1::DogsController < Api::ApplicationController
  include Api::V1::UserAuthenticator

  before_action :authenticate!

  def create
    dog = current_user.build_dog(dog_params)
    # unless current_user.dog.present?
    if dog&.save
      render json: dog
    else
      render json: { "message": 'Validation Failed' }, status: :bad_request
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :birthday)
  end
end
