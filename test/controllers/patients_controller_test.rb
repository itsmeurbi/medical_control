# frozen_string_literal: true

require "test_helper"

class PatientsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @patient = Patient.create!(name: 'Urbi',
                               birth_date: Time.zone.now - 26.years,
                               city: 'Colima',
                               address: '123 Street AV',
                               registered_at: Time.zone.now,
                               gender: 0)
  end

  test 'should index all patients' do
    get patients_path

    assert_response :success
  end

  test 'should create a patients' do
    registered_at = Time.current.strftime("%d/%m/%Y %H:%M")

    post patients_path(params: { patient: { name: 'Diego',
                                            age: 24,
                                            registered_at:,
                                            gender: 'masculino' } })

    assert_redirected_to patients_path
    assert_equal flash[:notice], 'Paciente creado correctamente'
  end

  test 'should visit new patient path and redirect to the new template' do
    get new_patient_path

    assert_response :success
  end

  test 'should visit edit patient path and redirect to the edit template' do
    get edit_patient_path(@patient)

    assert_response :success
  end

  test 'should update a patient information ' do
    registered_at = Time.current.strftime("%d/%m/%Y %H:%M")

    patch patient_path(@patient, params: { patient: { name: 'Diego',
                                                      age: 24,
                                                      registered_at:,
                                                      gender: 'masculino' } })

    assert_redirected_to edit_patient_path(@patient)
    assert_equal flash[:notice], 'Paciente actualizado correctamente'
  end

  test 'should delete a patient' do
    delete patient_path(@patient)

    assert_redirected_to patients_path
    assert_equal flash[:notice], 'Paciente eliminado permanentemente'
  end
end
