class HomeController < ApplicationController
  def index
    @fabricantes = []
    @fabricantes << Manufacturer.new(name: "Fiat")
    @fabricantes << Manufacturer.new(name: "Volkswagen")
  end
end
