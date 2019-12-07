require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'Admin must fill in all fields' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit new_manufacturer_path

    #fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'Admin must be unique' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit new_manufacturer_path

    Manufacturer.create(name: 'Fiat')
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    #trocar para mensagem mais genérica, ex. Voce deve resolver os seguintes erros para continuar.
  end

  scenario 'and must be logged in' do
    visit new_manufacturer_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Não autorizado')

  end

end
