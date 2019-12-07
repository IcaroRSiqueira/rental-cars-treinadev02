require 'rails_helper'

feature 'Admin delete car category' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    CarCategory.create(name: 'Esportivo Utilitário', daily_rate: 12.3, car_insurance: 45.6, third_party_insurance: 67.8)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Esportivo Utilitário'
    click_on 'Deletar Cate'

  expect(page).to have_content('Não existem categorias de carro cadastradas no sistema')
  end
end
