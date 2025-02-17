class CarModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def edit
    @car_model = CarModel.find(params[:id])
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def create
    @car_model = CarModel.new(car_model_params)
    if @car_model.save
      flash[:notice] = 'Modelo registrado com sucesso'
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  def update
    @car_model = CarModel.find(params[:id])
    if @car_model.update(car_model_params)
      flash[:notice] = 'Modelo atualizado com sucesso'
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @car_categories = CarCategory.all
      render :edit
    end
  end

  def destroy
    @car_model = CarModel.find(params[:id])
    @car_model.destroy
    redirect_to car_models_path
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :year, :motorization, :fuel_type,
                                      :car_category_id, :manufacturer_id)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:notice] = 'Não autorizado'
      redirect_to root_path
    end
  end

end
