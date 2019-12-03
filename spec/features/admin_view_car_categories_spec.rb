require 'rails_helper'
#Teste AAA
feature 'Visitor view car categories' do
  scenario 'successfully' do
#Arrange
    CarCategory.create(name: 'Esportivo Utilitário', daily_rate: 12.3, car_insurance: 45.6, third_party_insurance: 67.8)
#Act
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Esportivo Utilitário'
#Assert
  expect(page).to have_content('Esportivo Utilitário')
  expect(page).to have_content('12.3')
  expect(page).to have_content('45.6')
  expect(page).to have_content('67.8')
  end

  scenario 'and car categories are not registered' do
    visit root_path
    click_on 'Categorias de carros'
  expect(page).to have_content('Não existem categorias de carros cadastradas no sistema')
  end
end
