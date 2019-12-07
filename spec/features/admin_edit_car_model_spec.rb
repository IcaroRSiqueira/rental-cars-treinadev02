require 'rails_helper'

feature 'Admin edits car model' do
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
    click_on 'Editar'
    fill_in 'Nome', with: 'Corsa'
    fill_in 'Ano', with: '2015'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Gasolina'
    select 'Chevrolet', from: 'Fabricante'
    select 'A', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Corsa')
    expect(page).to have_content('2015')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('2015')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('A')
    expect(page).to have_content('Modelo atualizado com sucesso')


  end


scenario 'Admin must fill all fields' do
  user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

  login_as(user, scope: :user)
  Manufacturer.create!(name: 'Chevrolet')
  CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                      third_party_insurance: 90)


  visit root_path
  click_on 'Modelos de Carro'
  click_on 'Registrar novo modelo'

  fill_in 'Nome', with: ''
  fill_in 'Ano', with: '2020'
  fill_in 'Motorização', with: '1.0'
  fill_in 'Combustível', with: ''
  select 'Chevrolet', from: 'Fabricante'
  select 'A', from: 'Categoria'


  click_on 'Enviar'

  expect(page).to have_content('não pode ficar em branco')
end

scenario 'must be unique' do
  user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

  login_as(user, scope: :user)
  manufacturer = Manufacturer.create(name: 'Chevrolet')
  car_category = CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50,
                                    third_party_insurance: 90)
  CarModel.create!(name: 'Onix', year: 2015, fuel_type: 'Flex', motorization: 1.0,
                   manufacturer: manufacturer, car_category: car_category)
  visit root_path
  click_on 'Modelos de Carro'
  click_on 'Registrar novo modelo'

  fill_in 'Nome', with: 'Onix'
  fill_in 'Ano', with: '2020'
  fill_in 'Motorização', with: '1.0'
  fill_in 'Combustível', with: 'Gasolina'
  select 'Chevrolet', from: 'Fabricante'
  select 'A', from: 'Categoria'


  click_on 'Enviar'

  expect(page).to have_content('já está em uso')
end
end
