require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
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
    fill_in 'Cor', with: 'Preto'
    select 'Onix', from: 'Modelo'
    fill_in 'Quilometragem', with: 1000
    select 'Pompeia', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('CRS-3863')
    expect(page).to have_content('Preto')
    expect(page).to have_content('Onix')
    expect(page).to have_content('1000')
    expect(page).to have_content('Pompeia')

  end

  scenario 'and must be logged in' do
    visit new_car_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros disponíveis'

    expect(page).to have_content('Não autorizado')
  end

end
