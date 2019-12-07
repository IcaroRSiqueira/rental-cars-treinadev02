class SubsidiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      redirect_to @subsidiary
    else
      render :new
    end
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])
    if @subsidiary.update(subsidiary_params)
      flash[:notice] = 'Filial atualizada com sucesso'
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  def destroy
    @subsidiary = Subsidiary.find(params[:id])
    @subsidiary.destroy
    redirect_to subsidiaries_path
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:notice] = 'Não autorizado'
      redirect_to root_path
    end
  end

end
