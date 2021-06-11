class Api::V1::CareTypesController < ApplicationController
  def index
    json_string = CareType.all
    render json: json_string
  end
end
