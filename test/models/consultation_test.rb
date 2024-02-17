# frozen_string_literal: true

require "test_helper"

class ConsultationTest < ActiveSupport::TestCase
  test 'is not valid without patient' do
    consultation = Consultation.new

    assert_not consultation.valid?
    assert_equal 'must exist', consultation.errors.messages[:patient].first
  end

  test 'is not valid without date' do
    consultation = Consultation.new

    assert_not consultation.valid?
    assert_equal "can't be blank", consultation.errors.messages[:date].first
  end

  test 'is not valid without meds or procedure' do
    consultation = Consultation.new

    assert_not consultation.valid?
    assert_equal "can't be blank", consultation.errors.messages[:procedure].first
  end

  test 'is valid with patient, date and procedure or meds' do
    consultation = Consultation.new(date: Time.zone.today,
                                    patient: patients(:first_patient),
                                    procedure: 'Lorem impsum')

    assert consultation.valid?
  end
end
