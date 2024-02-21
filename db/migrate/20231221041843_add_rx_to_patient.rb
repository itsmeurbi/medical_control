# frozen_literal_string: true

class AddRxToPatient < ActiveRecord::Migration[7.0]
  def change
    change_table :patients, bulk: true do |t|
      t.boolean :rx, null: false, default: false
      t.boolean :cat, null: false, default: false
      t.boolean :mri, null: false, default: false
      t.boolean :us, null: false, default: false
      t.boolean :do, null: false, default: false
      t.boolean :emg, null: false, default: false
    end
  end
end
