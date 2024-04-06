# frozen_string_literal: true

class ConsultationsController < AuthController
  include Pagy::Backend

  def create
    @patient = Patient.find(params[:patient_id])
    @consultation = @patient.treatments.new(consultation_params)
    if @consultation.save
      redirect_to patients_path(@patient), notice: 'Tratamiento agregado'
    else
      redirect_to patients_path(@patient), alert: 'Error agregando tratamiento'
    end
  end

  def index
    @patient = Patient.find(params[:patient_id])
    @pagy, @treatments = pagy(@patient.treatments.order(created_at: :desc),
                              items: 1,
                              request_path: patient_consultations_path(@patient))
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:date, :meds, :procedure)
  end
end
