require 'rails_helper'

  feature 'user schedule rental' do
    scenario 'successfully' do
      user = User.create!(email: 'test@test.com', password: '123456', role: :employee)
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)


      login_as(user, scope: :user)
      visit root_path
      click_on 'Locaçōes'
      click_on 'Agendar Locação'
      fill_in 'Data de início', with: '09/12/2019'
      fill_in 'Data de fim', with: '12/12/2019'
      fill_in 'Código', with: 'AAA1000'
      select 'Fulano Sicrano - 123.123.123-12', from: 'Cliente'
      select category.name, from: 'Categoria do Carro'
      click_on 'Enviar'

      expect(page).to have_content('Data de início: 09/12/2019')
      expect(page).to have_content('Data de fim: 12/12/2019')
      expect(page).to have_content('Cliente')
      expect(page).to have_content('AAA1000')
      expect(page).to have_content(client.name)
      expect(page).to have_content(client.document)
      expect(page).to have_content(category.name)
      expect(page).to have_content('Locação agendada com sucesso')
      expect(page).to have_content('scheduled')
      expect(page).to have_link ('Iniciar Locação')



    end

    scenario 'user schedule, select car and confirm rental (in progress)' do
      user = User.create!(email: 'test@test.com', password: '123456', role: :employee)
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.create!(start_date: '09/12/2019', end_date: '12/12/2019', client: client, reservation_code: 'BCD2345', car_category: category)

      login_as(user, scope: :user)
      visit root_path
      click_on 'Locaçōes'
      click_on rental.reservation_code
      click_on 'Iniciar Locação'

      expect(page).to have_content('Data de início: 09/12/2019')
      expect(page).to have_content('Data de fim: 12/12/2019')
      expect(page).to have_content('Cliente')
      expect(page).to have_content(client.name)
      expect(page).to have_content(client.document)
      expect(page).to have_content(category.name)
      expect(page).to have_content('Locação em progresso')
      expect(page).to have_content('in_progress')
      expect(page).not_to have_link ('Iniciar Locação')


    end

    scenario 'and must fill all fields' do
      user = User.create!(email: 'test@test.com', password: '123456', role: :employee)
      Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)


      login_as(user, scope: :user)
      visit root_path
      click_on 'Locaçōes'
      click_on 'Agendar Locação'
      fill_in 'Data de início', with: ''
      fill_in 'Data de fim', with: '12/12/2019'
      select 'Fulano Sicrano - 123.123.123-12', from: 'Cliente'
      select category.name, from: 'Categoria do Carro'
      click_on 'Enviar'

      expect(page).to have_content('Datas devem existir')

    end

    scenario 'and start date must be less to end date' do
      user = User.create!(email: 'test@test.com', password: '123456', role: :employee)
      Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)


      login_as(user, scope: :user)
      visit root_path
      click_on 'Locaçōes'
      click_on 'Agendar Locação'
      fill_in 'Data de início', with: '15/12/2019'
      fill_in 'Data de fim', with: '12/12/2019'
      select 'Fulano Sicrano - 123.123.123-12', from: 'Cliente'
      select category.name, from: 'Categoria do Carro'
      click_on 'Enviar'

      expect(page).to have_content('deve ser maior que data de início')
    end
  end
