# frozen_string_literal: true

require 'application_system_test_case'

class PatientsTest < ApplicationSystemTestCase
  setup do
    visit patients_path
  end

  test 'should visit the patients index page and show them' do
    assert_content patients(:first_patient).name
  end

  test 'should visit new patient path, fill the fields and create it' do
    click_link 'Agregar paciente'
    fill_in 'Nombre', with: 'Diego'
    fill_in 'Edad', with: '25'
    fill_in 'F. de Ingreso', with: Time.current
    click_on 'Agregar paciente'

    assert_content 'Patient created successfully'
  end

  test 'should visit edit patient page, change fields and update it' do
    click_link 'Mostrar'
    fill_in 'Nombre', with: 'Diego'
    fill_in 'Edad', with: '25'
    fill_in 'F. de Ingreso', with: Time.current
    click_on 'Actualizar paciente'

    assert_content 'Patient updated successfully'
    assert_content 'Diego'
  end

  test 'should click on Regresar link, and check if its in main page' do
    click_link 'Mostrar'
    click_link 'Regresar'

    assert_content patients(:first_patient).name
  end

  test 'should click on Eliminar button and delete the patient' do
    accept_alert do
      click_on 'Eliminar'
    end

    assert_content 'Patient deleted successfully'
    assert_content 'No hay registros'
  end
end
