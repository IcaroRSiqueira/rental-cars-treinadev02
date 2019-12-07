require 'rails_helper'

feature 'Admin delete manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Deletar Fabricante'

  expect(page).to have_content('Não existem fabricantes cadastradas no sistema')
  end
end
