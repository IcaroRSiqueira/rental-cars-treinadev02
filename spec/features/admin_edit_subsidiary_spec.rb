require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')

    visit root_path
    click_on 'Filiais'
    click_on 'Pompeia'
    click_on 'Editar'
    fill_in 'Endereço', with: 'Rua Luis Inácio, Número 13, Estrela, SP'
    click_on 'Enviar'

    expect(page).to have_content('Rua Luis Inácio, Número 13, Estrela, SP')
    expect(page).to have_content('Filial atualizada com sucesso')

  end

  scenario 'Admin must fill in all fields' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')

    visit root_path
    click_on 'Filiais'
    click_on 'Pompeia'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'must be different' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    Subsidiary.create(name: 'Pompeia', cnpj: '12.345.678/9012-34', address: 'Av. Pompeia, Número 200, São Paulo, SP')
    Subsidiary.create(name: 'Toad Cars', cnpj: '21.456.876/0000-11', address: 'Av. Rainbow Road, 64, Mario, Nintendo')

    visit root_path
    click_on 'Filiais'
    click_on 'Pompeia'
    click_on 'Editar'
    fill_in 'Nome', with: 'Toad Cars'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
end
