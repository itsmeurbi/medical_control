class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.date :birth_date
      t.integer :age, null: false
      t.string :city
      t.string :address
      t.string :phone_number
      t.string :medical_record
      t.datetime :registered_at, null: false
      t.integer :gender, null: false
      t.integer :marital_status
      t.string :reference
      t.string :occupations
      t.text :primary_dx
      t.text :initial_dx
      t.text :final_dx
      t.text :medical_background
      t.text :surgical_background
      t.text :interventionism_tx
      t.string :pain_type
      t.string :pain_localization
      t.string :pain_evolution
      t.string :pain_duration
      t.string :pain_last_time
      t.string :pain_initial_state
      t.string :pain_current_state
      t.string :alergies
      t.string :irradiations
      t.integer :evaluation
      t.integer :evara
      t.string :previous_tx
      t.integer :blood_type
      t.integer :rh_factor
      t.float :weight
      t.float :height
      t.integer :blood_pressure
      t.integer :heart_rate
      t.integer :breath_rate
      t.text :general_inspection
      t.text :head
      t.text :abdomen
      t.text :neck
      t.text :extremities
      t.text :spine
      t.text :chest
      t.text :laboratory
      t.text :cabinet
      t.text :consultations
      t.text :requested_studies
      t.date :tx_date
      t.text :tx_procedure
      t.text :medicines

      t.timestamps
    end
  end
end
