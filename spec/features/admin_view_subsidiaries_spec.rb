require 'rails_helper'
#Teste AAA
feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
#Arrange
    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')
#Act
    visit root_path
    click_on 'Filiais'
    click_on 'Pompeia'
#Assert
  expect(page).to have_content('Pompeia')
  expect(page).to have_content('12.345.678/9012-34')
  expect(page).to have_content('Av. Pompeia, Número 200, São Paulo, SP')
  end

  scenario 'and subsidiaries are not registered' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

  expect(page).to have_content('Não existem filiais cadastradas no sistema')
  end
end
