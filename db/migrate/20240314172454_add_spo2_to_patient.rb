class AddSpo2ToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :spo2, :string
  end
end
