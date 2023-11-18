class AddConsultationsReceivedToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :consultations_received, :integer
  end
end
