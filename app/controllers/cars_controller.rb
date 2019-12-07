class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  
  def index
    @car = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    @car = Car.new(car_params)
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
    if @car.save
      redirect_to @car
    else
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :mileage,
                   :car_model_id, :subsidiary_id)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:notice] = 'Não autorizado'
      redirect_to root_path
    end
  end

end
