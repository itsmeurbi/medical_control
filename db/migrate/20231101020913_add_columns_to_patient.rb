class AddColumnsToPatient < ActiveRecord::Migration[7.0]
  def change
    change_table :patients, bulk: true do |t|
      t.string  :anticoagulants
      t.string  :cellphone_number
      t.string  :chronics
      t.string  :fiscal_situation
      t.string  :email
      t.string  :zip_code
    end
  end
end
