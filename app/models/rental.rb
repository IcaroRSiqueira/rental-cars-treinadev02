class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  validates :start_date, :end_date, presence: true

  validate :end_date_must_be_greater_than_start_date

  def end_date_must_be_greater_than_start_date
    if start_date.blank? || end_date.blank?
      return errors.add(:base, 'Datas devem existir')
    end

    if end_date <= start_date
      errors.add(:end_date, 'deve ser maior que data de início')
    end
  end

  def self.search(search)
    if search
      code = Rental.where(reservation_code: search)
    else
      Rental.all
    end
  end

  enum status: [:scheduled, :in_progress]
end
