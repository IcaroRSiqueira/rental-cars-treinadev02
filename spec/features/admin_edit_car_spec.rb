require 'rails_helper'

feature 'Admin edits car model' do
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
    click_on 'Editar'

    fill_in 'Placa', with: 'GGG-1111'
    fill_in 'Cor', with: 'Vermelho'
    select 'Onix', from: 'Modelo'
    fill_in 'Quilometragem', with: 1000
    select 'Siqueira Cars', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('GGG-1111')
    expect(page).to have_content('Vermelho')
    expect(page).to have_content('Onix')
    expect(page).to have_content('1000')
    expect(page).to have_content('Siqueira Cars')
    expect(page).to have_content('Carro atualizado com sucesso')
  end

  scenario 'admin must fill all fields' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')
    manufacturer = Manufacturer.create(name: 'Chevrolet')
    car_category = CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50,
                                      third_party_insurance: 90)
    CarModel.create!(name: 'Onix', year: 2015, fuel_type: 'Flex', motorization: 1.0,
                     manufacturer: manufacturer, car_category: car_category)
    visit root_path

    click_on 'Carros disponíveis'
    click_on 'Cadastrar um carro para a frota'

    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    select 'Onix', from: 'Modelo'
    fill_in 'Quilometragem', with: 1000
    select 'Pompeia', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'plate must be unique' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')
    subsidiary = Subsidiary.create(name: 'Siqueira Cars', cnpj: '13.445.658/6072-38', address: 'Av. Pres Vargas, Número 200, São Paulo, SP')

    manufacturer = Manufacturer.create(name: 'Chevrolet')
    car_category = CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50,
                                      third_party_insurance: 90)
    CarModel.create(name: 'Onix', year: 2015, fuel_type: 'Flex', motorization: 1.0,
                    manufacturer: manufacturer, car_category: car_category)
    car_model = CarModel.create(name: 'Corsa', year: 2015, fuel_type: 'Flex', motorization: 1.0,
                                manufacturer: manufacturer, car_category: car_category)

    Car.create!(license_plate: 'AAA-0000', color: 'Vermelho', mileage: 250, car_model: car_model, subsidiary: subsidiary)

    visit root_path

    click_on 'Carros disponíveis'
    click_on 'Cadastrar um carro para a frota'

    fill_in 'Placa', with: 'AAA-0000'
    fill_in 'Cor', with: 'Branco'
    select 'Onix', from: 'Modelo'
    fill_in 'Quilometragem', with: 1000
    select 'Pompeia', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'mileage must be >0' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')
    manufacturer = Manufacturer.create(name: 'Chevrolet')
    car_category = CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50,
                                      third_party_insurance: 90)
    CarModel.create!(name: 'Onix', year: 2015, fuel_type: 'Flex', motorization: 1.0,
                     manufacturer: manufacturer, car_category: car_category)
    visit root_path

    click_on 'Carros disponíveis'
    click_on 'Cadastrar um carro para a frota'

    fill_in 'Placa', with: 'CRS-3863'
    fill_in 'Cor', with: ''
    select 'Onix', from: 'Modelo'
    fill_in 'Quilometragem', with: 0
    select 'Pompeia', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('must be greater than 0')
  end
end
