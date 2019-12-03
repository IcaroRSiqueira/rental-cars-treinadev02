require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Siqueira Cars'
    fill_in 'CNPJ', with: '12.345.678/9012-34'
    fill_in 'Endereço', with: 'Rua Luis Inácio, Número 13, Estrela, SP'
    click_on 'Enviar'

    expect(page).to have_content('Siqueira Cars')
    expect(page).to have_content('12.345.678/9012-34')
    expect(page).to have_content('Rua Luis Inácio, Número 13, Estrela, SP')

  end
end
