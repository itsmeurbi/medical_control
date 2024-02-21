class RemoveNoNeededPatientFields < ActiveRecord::Migration[7.0]
  def change
    change_table :patients, bulk: true do |t|
      t.remove :tx_date, type: :date
      t.remove :tx_procedure, type: :text
      t.remove :medicines, type: :text
    end
  end
end
