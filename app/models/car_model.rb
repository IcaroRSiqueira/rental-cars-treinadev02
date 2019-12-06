class CarModel < ApplicationRecord
  validates :name, :motorization, :year, :fuel_type, :manufacturer_id, :car_category_id, presence: {message: 'não pode ficar em branco'}
  validates :name, uniqueness: {message: 'já está em uso'}
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :car
end
