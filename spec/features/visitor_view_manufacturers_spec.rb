require 'rails_helper'
#Teste AAA
feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
#Arrange
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')
#Act
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
#Assert
    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_link ('Fabricantes')
  end

end
