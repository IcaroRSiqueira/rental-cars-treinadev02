class Car < ApplicationRecord
  validates :license_plate, :color, :mileage, :car_model_id, :subsidiary_id, presence: {message: 'não pode ficar em branco'}
  validates :license_plate, uniqueness: {message: 'já está em uso'}
  validates :mileage, numericality: { greater_than: 0 }
  belongs_to :car_model
  belongs_to :subsidiary
end
