class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.belongs_to :patient, null: false, foreign_key: true
      t.text :procedure
      t.text :meds
      t.date :date

      t.timestamps
    end
  end
end
