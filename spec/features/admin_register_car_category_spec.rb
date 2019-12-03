require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do
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
end
