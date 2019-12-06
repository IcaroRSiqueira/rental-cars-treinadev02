class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: {message: 'não pode ficar em branco'}
  validates :name, :cnpj, :address, uniqueness: {message: 'já está em uso'}
  has_many :cars
end
