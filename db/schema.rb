# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_29_024955) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consultations", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.text "procedure"
    t.text "meds"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.date "birth_date"
    t.string "city"
    t.string "address"
    t.string "phone_number"
    t.string "medical_record"
    t.datetime "registered_at", null: false
    t.integer "gender", null: false
    t.integer "marital_status"
    t.string "reference"
    t.string "occupations"
    t.text "primary_dx"
    t.text "initial_dx"
    t.text "final_dx"
    t.text "medical_background"
    t.text "surgical_background"
    t.text "interventionism_tx"
    t.string "pain_type"
    t.string "pain_localization"
    t.string "pain_evolution"
    t.string "pain_duration"
    t.string "pain_initial_state"
    t.string "pain_current_state"
    t.string "alergies"
    t.string "irradiations"
    t.integer "evaluation"
    t.integer "evera"
    t.string "previous_tx"
    t.integer "blood_type"
    t.integer "rh_factor"
    t.float "weight"
    t.float "height"
    t.string "blood_pressure"
    t.integer "heart_rate"
    t.integer "breath_rate"
    t.text "general_inspection"
    t.text "head"
    t.text "abdomen"
    t.text "neck"
    t.text "extremities"
    t.text "spine"
    t.text "chest"
    t.text "laboratory"
    t.text "cabinet"
    t.text "consultations"
    t.text "requested_studies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "anticoagulants"
    t.string "cellphone_number"
    t.string "chronics"
    t.string "fiscal_situation"
    t.string "email"
    t.string "zip_code"
    t.boolean "rx", default: false, null: false
    t.boolean "cat", default: false, null: false
    t.boolean "mri", default: false, null: false
    t.boolean "us", default: false, null: false
    t.boolean "do", default: false, null: false
    t.boolean "emg", default: false, null: false
    t.string "spo2"
    t.string "increases_with"
    t.string "decreases_with"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consultations", "patients"
end
