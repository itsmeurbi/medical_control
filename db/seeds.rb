# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'

# Create 1000 fake patients
1000.times do
  gender = Patient.genders.keys.sample
  first_name = gender == 'masculino' ? Faker::Name.first_name : Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = "#{first_name} #{last_name}"

  Patient.create!(
    name: name,
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 90),
    city: Faker::Address.city,
    address: Faker::Address.street_address,
    phone_number: Faker::Number.number(digits: 10),
    cellphone_number: Faker::Number.number(digits: 10),
    registered_at: Faker::Date.between(from: 1.year.ago, to: Date.today),
    gender: gender,
    marital_status: Patient.marital_statuses.keys.sample,
    occupations: Faker::Job.title,
    primary_dx: Faker::Lorem.paragraph(sentence_count: 2),
    medical_background: Faker::Lorem.paragraph(sentence_count: 3),
    surgical_background: Faker::Lorem.paragraph(sentence_count: 2),
    pain_type: ['Agudo', 'Crónico', 'Punzante', 'Sordo'].sample,
    pain_localization: ['Cabeza', 'Espalda', 'Rodilla', 'Hombro', 'Cuello'].sample,
    alergies: ['Ninguna', 'Penicilina', 'Sulfas', 'Ibuprofeno'].sample,
    blood_type: Patient.blood_types.keys.sample,
    rh_factor: Patient.rh_factors.keys.sample,
    weight: Faker::Number.between(from: 45.0, to: 120.0).round(1),
    height: Faker::Number.between(from: 150.0, to: 200.0).round(1),
    blood_pressure: "#{Faker::Number.between(from: 90, to: 140)}/#{Faker::Number.between(from: 60, to: 90)}",
    heart_rate: Faker::Number.between(from: 60, to: 100),
    breath_rate: Faker::Number.between(from: 12, to: 20),
    email: Faker::Internet.email,
    zip_code: Faker::Address.zip_code,
    fiscal_situation: ['Activo', 'Inactivo'].sample,
    spo2: "#{Faker::Number.between(from: 95, to: 100)}%"
  )
end

puts "Created 1000 fake patients!"