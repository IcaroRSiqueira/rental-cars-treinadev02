require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
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

  scenario 'must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Não autorizado')

  end
end
