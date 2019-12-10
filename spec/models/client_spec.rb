require 'rails_helper'

describe Client do
  describe '.description' do
    it 'must return name with document' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com', document: '123.123.123-12')

      expect(client.description).to eq 'Fulano Sicrano - 123.123.123-12'
    end
  end
end
