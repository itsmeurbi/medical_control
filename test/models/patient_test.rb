# frozen_string_literal: true

require "test_helper"

class PatientTest < ActiveSupport::TestCase
  test 'it is not vaild without name' do
    patient = Patient.new

    assert_not patient.valid?
    assert_equal patient.errors[:name].first, "can't be blank"
  end

  test 'it is not vaild without date of entry' do
    patient = Patient.new

    assert_not patient.valid?
    assert_equal patient.errors[:registered_at].first, "can't be blank"
  end

  test 'it is not vaild without gender' do
    patient = Patient.new

    assert_not patient.valid?
    assert_equal patient.errors[:gender].first, "can't be blank"
  end

  test 'it is not valid if phone number is lower or greater than 10 digits' do
    patient = Patient.new(phone_number: '31231212')

    assert_not patient.valid?
    assert_equal patient.errors[:phone_number].first, 'is the wrong length (should be 10 characters)'
  end

  test 'it is not valid if phone number does not contain only numbers' do
    patient = Patient.new(phone_number: '111111d111')

    assert_not patient.valid?
    assert_equal patient.errors[:phone_number].first, 'only allows numbers'
  end

  test 'it is valid with name, date of entry and gender' do
    date_time = Time.current.strftime("%d/%m/%Y %H:%M")

    patient = Patient.new(name: "Urbi", registered_at: date_time, gender: 1)

    assert patient.valid?
  end

  test 'it is valid if phone number is 10 chars lenght and contains only nombers' do
    date_time = Time.current.strftime("%d/%m/%Y %H:%M")

    patient = Patient.new(name: "Urbi", registered_at: date_time, gender: 1, phone_number: '3414200512')

    assert patient.valid?
  end
end
