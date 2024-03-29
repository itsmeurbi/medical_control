# frozen_string_literal: true

class Patient < ApplicationRecord
  include PgSearch::Model

  encrypts :name, :phone_number, :address, :city

  pg_search_scope :whose_fullname_contains,
                  against: :name,
                  using: {
                    tsearch: { prefix: true }
                  }

  enum gender: { masculino: 0, femenino: 1 }
  enum marital_status: { casado: 0, divorciado: 1, soltero: 2, union_libre: 3, viudo: 4 }
  enum evera: { leve: 0, moderado: 1, fuerte: 2, muy_fuerte: 3, insoportable: 4 }
  enum blood_type: { a: 0, b: 1, ab: 2, o: 3 }
  enum :rh_factor, { negativo: 0, positivo: 1 }, prefix: :rh
  validates :name, :registered_at, :gender, presence: true
  validates :phone_number, :cellphone_number, length: { is: 10 }, allow_blank: true
  validates :phone_number, :cellphone_number, format: { with: /\A\d+\Z/,
                                                        message: 'only allows numbers' }, allow_blank: true

  has_many :treatments, class_name: 'Consultation', inverse_of: :patient, dependent: :restrict_with_error

  accepts_nested_attributes_for :treatments, reject_if: ->(attrs) { attrs[:meds].blank? && attrs[:procedure].blank? }

  def age
    return nil unless birth_date

    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

  def medical_record
    return nil if new_record?

    "EXP#{id}"
  end
end
