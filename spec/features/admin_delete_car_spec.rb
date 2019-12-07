require 'rails_helper'

feature 'Admin delete car' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    subsidiary = Subsidiary.create(name: 'Siqueira Cars', cnpj: '13.445.658/6072-38', address: 'Av. Pres Vargas, Número 200, São Paulo, SP')
    manufacturer = Manufacturer.create(name: 'Chevrolet')
    car_category = CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50,
                                      third_party_insurance: 90)
    car_model = CarModel.create(name: 'Onix', year: 2015, fuel_type: 'Flex', motorization: 1.0,
                                manufacturer: manufacturer, car_category: car_category)

    Car.create!(license_plate: 'AAA-0000', color: 'Vermelho', mileage: 250, car_model: car_model, subsidiary: subsidiary)

    visit root_path

    click_on 'Carros disponíveis'
    click_on 'Onix'
    click_on 'Deletar Carro'

  expect(page).to have_content('Não existem carros cadastrados no sistema')
  end
end
