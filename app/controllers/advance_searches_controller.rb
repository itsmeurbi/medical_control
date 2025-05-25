# frozen_string_literal: true

class AdvanceSearchesController < AuthController
  include Pagy::Backend

  def new
    respond_to do |format|
      format.turbo_stream
    end
  end

  def index
    @pagy, @patients = pagy(Patient.advanced_search(search_params), items: 5)
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def search_params
    params.permit(:attribute_name, :attribute_value, :page, :match_type)
  end
end
