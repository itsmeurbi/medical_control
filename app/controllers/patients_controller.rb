# frozen_string_literal: true

class PatientsController < ApplicationController
  include Pagy::Backend

  before_action :find_patient, only: %i[edit update destroy]
  PATIENT_CUSTOM_PARAMS = %i[ name birth_date age city address phone_number medical_record
                              registered_at gender marital_status reference primary_dx initial_dx
                              final_dx medical_background surgical_background interventionism_tx
                              pain_type pain_localization pain_evolution pain_duration
                              pain_last_time pain_initial_state pain_current_state
                              irradiations evaluation evara previous_tx occupations primary_dx
                              initial_dx final_dx medical_background surgical_background
                              interventionism_tx pain_type pain_localization pain_evolution
                              pain_duration pain_last_time pain_initial_state pain_current_state
                              alergies irradiations evaluation evara previous_tx blood_type
                              rh_factor weight height blood_pressure heart_rate breath_rate
                              general_inspection head abdomen neck extremities spine chest
                              laboratory cabinet consultations requested_studies tx_date
                              tx_procedure medicines anticoagulants cellphone_number email
                              chronics fiscal_situation zip_code ].freeze

  def index
    @patients = Patient.all
    respond_to do |format|
      format.html
      format.json { render json: Patient.whose_fullname_contains(params[:text]) }
    end
  end

  def create
    @patient = Patient.new(permitted_params)
    if @patient.save
      flash[:notice] = 'Patient created successfully'
      redirect_to patients_path
    else
      flash.now[:alert] = 'Error while creating patient'
      render :new
    end
  end

  def new
    @patient = Patient.new
  end

  def edit
    @pagy, @treatments = pagy(@patient.treatments, items: 1)
  end

  def update
    if @patient.update(permitted_params)
      flash[:notice] = 'Patient updated successfully'
      redirect_to patients_path
    else
      flash.now[:alert] = 'Error while updating patient'
      render :edit
    end
  end

  def destroy
    if @patient.destroy
      flash[:notice] = 'Patient deleted successfully'
    else
      flash[:alert] = 'Error while deleting patient'
    end
    redirect_to patients_path
  end

  private

  # rubocop:disable Metrics/MethodLength
  def permitted_params
    params.require(:patient)
          .permit(:name, :birth_date, :age, :city, :address, :phone_number, :medical_record,
                  :registered_at, :gender, :marital_status, :reference, :primary_dx, :initial_dx,
                  :final_dx, :medical_background, :surgical_background, :interventionism_tx,
                  :pain_type, :pain_localization, :pain_evolution, :pain_duration, :pain_last_time,
                  :pain_initial_state, :pain_current_state, :irradiations, :evaluation, :evara,
                  :previous_tx, :occupations, :primary_dx, :initial_dx, :final_dx,
                  :medical_background, :surgical_background, :interventionism_tx,
                  :pain_type, :pain_localization, :pain_evolution, :pain_duration, :pain_last_time,
                  :pain_initial_state, :pain_current_state, :alergies, :irradiations, :evaluation,
                  :evara, :previous_tx, :blood_type, :rh_factor, :weight, :height, :blood_pressure,
                  :heart_rate, :breath_rate, :general_inspection, :head, :abdomen, :neck,
                  :extremities, :spine, :chest, :laboratory, :cabinet, :consultations, :evera,
                  :requested_studies, :anticoagulants, :cellphone_number, :email, :chronics,
                  :fiscal_situation, :zip_code, treatments_attributes: [:date, :meds, :procedure])
  end
  # rubocop:enable Metrics/MethodLength

  def find_patient
    @patient = Patient.find(params[:id])
  end
end
