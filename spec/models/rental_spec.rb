require 'rails_helper'

describe Rental do
  describe '.end_date_must_be_greater_than_start_date' do
    it 'success' do
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: category)

      rental.valid?

      expect(rental.errors).to be_empty
      #same than expect(rental.errors.empty?).to eq true
    end

    it 'end date less than start date' do
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '09/12/2019', end_date: '08/12/2019', client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'End date deve ser maior que data de início'
    end

    it 'end date equal than start date' do
    end

    it 'start date must exist' do
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: nil, end_date: '08/12/2019', client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas devem existir'
    end

    it 'start date must not be empty string' do
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '', end_date: '08/12/2019', client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas devem existir'
    end

    it 'end date must exist' do
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '08/12/2019', end_date: nil, client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas devem existir'
    end

    it 'end date must not be empty string' do
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '08/12/2019', end_date: '', client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas devem existir'
    end

    it 'end date equal to start date' do
      client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')
      category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '08/12/2019', end_date: '08/12/2019', client: client, car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'End date deve ser maior que data de início'
    end
  end
end
