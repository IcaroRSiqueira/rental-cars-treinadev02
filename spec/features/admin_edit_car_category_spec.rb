require 'rails_helper'

feature 'Admin edits car_category' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    CarCategory.create(name: 'Esportivo Utilitário', daily_rate: 12.3, car_insurance: 45.6, third_party_insurance: 67.8)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Esportivo Utilitário'
    click_on 'Editar'
    fill_in 'Nome', with: 'Sedan'
    click_on 'Enviar'

    expect(page).to have_content('Sedan')
    expect(page).to have_content('Categoria de carro atualizada com sucesso')

  end

  scenario 'Admin must fill in all fields' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    CarCategory.create(name: 'Esportivo Utilitário', daily_rate: 12.3, car_insurance: 45.6, third_party_insurance: 67.8)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Esportivo Utilitário'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'must be unique' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    CarCategory.create(name: 'Esportivo Utilitário', daily_rate: 12.3, car_insurance: 45.6, third_party_insurance: 67.8)
    CarCategory.create(name: 'Sedan', daily_rate: 22.3, car_insurance: 20.6, third_party_insurance: 65.8)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Esportivo Utilitário'
    click_on 'Editar'
    fill_in 'Nome', with: 'Sedan'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
end
