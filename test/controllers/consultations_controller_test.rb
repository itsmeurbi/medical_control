# frozen_string_literal: true

require "test_helper"

class ConsultationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test 'it fails creating a consultation if missing data' do
    post patient_consultations_path(patients(:first_patient)), params: { consultation: { date: Time.zone.today } }

    assert_response :redirect
    assert_equal 'Error agregando tratamiento', flash[:alert]
  end

  test 'it creates a consultation with correct data' do
    post patient_consultations_path(patients(:first_patient)),
         params: { consultation: { date: Time.zone.today, meds: 'Lorem impsum' } }

    assert_response :redirect
    assert_equal 'Tratamiento agregado', flash[:notice]
  end
end
