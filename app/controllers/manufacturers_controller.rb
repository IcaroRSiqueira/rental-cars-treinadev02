class ManufacturersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  def index
    @manufacurers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      redirect_to @manufacturer
    else
      render :new
    end
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = 'Fabricante atualizada com sucesso'
      redirect_to @manufacturer
    else
      render :edit
    end
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:notice] = 'Não autorizado'
      redirect_to root_path
    end
  end
end
