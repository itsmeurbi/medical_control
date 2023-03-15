# frozen_string_literal: true

class Patient < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :whose_fullname_contains,
                  against: :name,
                  using: {
                    tsearch: { prefix: true }
                  }

  enum gender: { masculino: 0, femenino: 1 }
  enum marital_status: { casado: 0, divorciado: 1, soltero: 2, union_libre: 3, viudo: 4 }
  enum evara: { leve: 0, moderado: 1, fuerte: 2, muy_fuerte: 3, insoportable: 4 }
  enum blood_type: { a: 0, b: 1, ab: 2, o: 3 }
  enum :rh_factor, { negativo: 0, positivo: 1 }, prefix: :rh
  validates :name, :age, :registered_at, :gender, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0, less_than: 110 }
  validates :phone_number, length: { is: 10 }, allow_blank: true
  validates :phone_number, format: { with: /\A\d+\Z/,
                                     message: 'only allows numbers' }, allow_blank: true
end
