require 'rails_helper'

feature 'Admin delete car model' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    manufacturer = Manufacturer.create(name: 'Chevrolet')
    car_category = CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50,
                                      third_party_insurance: 90)
    CarModel.create!(name: 'Onix', year: 2015, fuel_type: 'Flex', motorization: 1.0,
                     manufacturer: manufacturer, car_category: car_category)
    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Onix'
    click_on 'Deletar Modelo'

  expect(page).to have_content('Não existem modelos de carro cadastrados no sistema')
  end
end
