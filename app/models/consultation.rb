# frozen_string_literal: true

class Consultation < ApplicationRecord
  belongs_to :patient

  validates :date, presence: true
  validates :procedure, presence: true, if: ->(record) { record.meds.blank? }
  validates :meds, presence: true, if: ->(record) { record.procedure.blank? }
end
