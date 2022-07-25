class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    render json: Camper.all
  end

  def show
    camper = find_camper
    render json: camper, serializer: CamperAndActivitiesSerializer

  end

  def create
    camper = Camper.create!(camp_params)
    render json: camper, status: :created
  end

  private

  def camp_params
    params.permit(:name, :age)
  end

  def find_camper
    Camper.find(params[:id])
  end

  def render_not_found
    render json: { error: "Camper not found" }, status: :not_found

  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
