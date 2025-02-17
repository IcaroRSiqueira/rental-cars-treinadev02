require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do

    user = User.create!(email: 'test@test.com', password: '123456')

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within ('form') do
      click_on 'Log in'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_link ('Sair')
    expect(page).not_to have_link ('Entrar')

  end

    scenario 'user sign out' do

      user = User.create!(email: 'test@test.com', password: '123456')

      visit root_path

      click_on 'Entrar'

      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.password

      click_on 'Log in'
      click_on 'Sair'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Signed out successfully")
      expect(page).to have_link ('Entrar')
      expect(page).not_to have_link ('Sair')

    end

end
