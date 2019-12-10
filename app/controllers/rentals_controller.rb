class RentalsController < ApplicationController

  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      @rental.scheduled!
      redirect_to @rental, notice: 'Locação agendada com sucesso'
    else
      @clients = Client.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def search
    @rentals = Rental.search(params[:q])
    render :index
  end

  def start
    @rental = Rental.find(params[:id])
    @rental.in_progress!
    redirect_to @rental, notice: 'Locação em progresso'
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id, :reservation_code)
  end
end
