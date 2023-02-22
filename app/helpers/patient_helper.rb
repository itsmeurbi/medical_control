# frozen_string_literal: true

module PatientHelper
  def gender_select_options
    Patient.genders.map { |k, _v| [k.titleize, k] }
  end

  def marital_status_select_options
    Patient.marital_statuses.map { |k, _v| [k.titleize, k] }
  end

  def evara_select_options
    Patient.evaras.map { |k, _v| [k.titleize, k] }
  end

  def blood_type_select_options
    Patient.blood_types.map { |k, _v| [k.titleize, k] }
  end

  def rh_factor_select_options
    Patient.rh_factors.map { |k, _v| [k.titleize, k] }
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
