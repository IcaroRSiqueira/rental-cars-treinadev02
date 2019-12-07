require 'rails_helper'

feature 'Admin register car category' do

  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: 'Sedan'
    fill_in 'Valor da diária', with: '119,90'
    fill_in 'Seguro do carro', with: '99,90'
    fill_in 'Seguro contra terceiros', with: '149,90'
    click_on 'Enviar'

    expect(page).to have_content('Sedan')
    expect(page).to have_content('119.0')
    expect(page).to have_content('99.0')
    expect(page).to have_content('149.0')

  end

  scenario 'and must be logged in' do
    visit new_car_category_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Não autorizado')
  end

end
