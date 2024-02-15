# frozen_string_literal: true

class ConsultationsController < ApplicationController
  def create
    @patient = Patient.find(params[:patient_id])
    @consultation = @patient.treatments.new(consultation_params)
    if @consultation.save
      redirect_to patients_path(@patient), notice: 'Tratamiento agregado'
    else
      redirect_to patients_path(@patient), alert: 'Error agregando tratamiento'
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:date, :meds, :procedure)
  end
end
