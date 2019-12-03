require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'Admin must fill in all fields' do
    visit new_manufacturer_path

    #fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'Admin must be unique' do
    visit new_manufacturer_path

    Manufacturer.create(name: 'Fiat')
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    #trocar para mensagem mais genérica, ex. Voce deve resolver os seguintes erros para continuar.
  end
end
