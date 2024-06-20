# frozen_string_literal: true

class ConsultationsController < AuthController
  include Pagy::Backend
  before_action :find_consultation, only: %i[edit update destroy]

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

  def edit; end

  def update
    if @consultation.update(consultation_params)
      flash[:notice] = 'Tratamiento actualizado correctamente'
      redirect_to edit_patient_path(@consultation.patient_id)
    else
      flash.now[:alert] = 'Error al acutalizar el tratamiento'
      render :edit
    end
  end

  def destroy
    @consultation.destroy
    redirect_to patient_consultations_path(@consultation.patient)
  end

  private

  def find_consultation
    @consultation = Consultation.find(params[:id])
  end

  def consultation_params
    params.require(:consultation).permit(:date, :meds, :procedure)
  end
end
