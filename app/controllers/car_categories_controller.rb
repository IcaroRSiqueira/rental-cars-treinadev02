class CarCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  def new
    @car_category = CarCategory.new
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end

  def create
    if @car_category = CarCategory.new(car_category_params)
      @car_category.save
      redirect_to @car_category
    else
      render :new
    end
  end

  def update
    @car_category = CarCategory.find(params[:id])
    if @car_category.update(car_category_params)
      flash[:notice] = 'Categoria de carro atualizada com sucesso'
      redirect_to @car_category
    else
      render :edit
    end
  end

  def destroy
    @car_category = CarCategory.find(params[:id])
    @car_category.destroy
    redirect_to car_categories_path
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:notice] = 'Não autorizado'
      redirect_to root_path
    end
  end

end
