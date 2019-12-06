require 'rails_helper'

feature 'Admin register client' do
  scenario 'successfully' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Luis Inacio'
    fill_in 'CPF', with: '25.465.628-45'
    fill_in 'Email', with: 'lula@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Luis Inacio')
    expect(page).to have_content('25.465.628-45')
    expect(page).to have_content('lula@gmail.com')

  end
end
