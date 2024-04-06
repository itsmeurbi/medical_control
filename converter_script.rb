# frozen_string_literal: true

require 'csv'
require 'smarter_csv'

DB_FILE_PATH = 'Amilcar.mdb'
MARITAL_STATUS_MAPPING = { 'Soltero (a)' => 2, 'Divorciado (a)' => 1, 'Casado (a)' => 0, 'Viudo   (a)' => 4 }.freeze
EVERA_MAPPING = {
  '0' => 0,
  'Fuerte' => 2,
  'Insoportable' => 4,
  'Muy Fuerte' => 3,
  'Moderado' => 1,
  '' => 0,
  'Leve' => 0,
  'Leve/Muy Fuerte' => 1,
  'mod/muy fuerte' => 2,
  'Moderado/Fuerte' => 1,
  'Moderado/Muy fuerte' => 2,
  'leve/muy fuerte' => 1,
  'Leve/Fuerte' => 1
}.freeze
DATE_REGEX = %r{(\d{2})/(\d{2})/(\d{2})}
not_found_patients = []

raise "Missing #{DB_FILE_PATH} file" unless File.exist?(DB_FILE_PATH)

unless system('which mdb-tables > /dev/null 2>&1')
  puts 'See -> https://github.com/mdbtools/mdbtools'
  raise 'Missing mdb-tables file'
end

table_names = `mdb-tables -d , #{DB_FILE_PATH}`.chop.split(',')
table_names.each do |table|
  `mdb-export #{DB_FILE_PATH} '#{table}' > tmp/#{table.gsub(' ', '_')}.csv`
end

def sanitize_phone_number(number)
  return nil if number.blank?

  number = number.to_s.gsub(/\s+/, '').gsub(/\D/, '')
  if number.size == 7
    "312#{number}"
  else
    number
  end
end

def sanitize_dob(date_string)
  return nil if date_string.blank?

  match = date_string.match(DATE_REGEX)
  month = match[1]
  day = match[2]
  year = match[3] > '24' ? "19#{match[3]}" : "20#{match[3]}"
  Time.strptime("#{month}/#{day}/#{year}", '%m/%d/%Y').to_date
end

Consultation.delete_all
Patient.delete_all

# rubocop:disable Metrics/BlockLength
SmarterCSV.process('tmp/Pacientes.csv') do |chunk|
  chunk.each do |row|
    registered_at = if row[:fecha_de_ingreso]
                      Time.strptime(row[:fecha_de_ingreso], '%m/%d/%y')
                    else
                      Time.zone.now
                    end
    birth_date = sanitize_dob(row[:fechanac])
    cellphone_number = row[:celular] || row[:tels]
    patient = Patient.new
    patient.id = row[:idpacientes]
    patient.registered_at = registered_at
    patient.name = row[:nombre] || ''
    patient.gender = row[:sexo] == 'M' ? 0 : 1
    patient.marital_status = MARITAL_STATUS_MAPPING[row[:edocivil]]
    patient.reference = row[:referencia]
    patient.address = row[:domicilio]
    patient.city = row[:ciudad]
    patient.initial_dx = row[:dx_a_inicial]
    patient.final_dx = row[:dx_a_final]
    patient.rx = row[:rx]
    patient.emg = row[:emg]
    patient.mri = row[:irm]
    patient.do = row[:do]
    patient.birth_date = birth_date
    patient.interventionism_tx = row[:intervencionismo]
    patient.primary_dx = row[:dx_primario]
    patient.occupations = row[:ocupacion]
    patient.medical_background = row[:antecedentes]
    patient.surgical_background = row[:quirurgicos]
    patient.cellphone_number = sanitize_phone_number(cellphone_number)
    patient.save(validate: false)
  end
end
# rubocop:enable Metrics/BlockLength

SmarterCSV.process('tmp/Caracteristicas_del_Dolor.csv') do |chunk|
  chunk.each do |row|
    patient = Patient.find_by(id: row[:idpacientes])
    if patient.blank?
      not_found_patients << row[:idpacientes]
      next puts "Patient #{row[:idpacientes]} not found"
    end

    patient.alergies = row[:alergias]
    patient.pain_initial_state = row[:inicio]
    patient.pain_evolution = row[:evolucion]
    patient.pain_current_state = row[:edo_actual]
    patient.pain_type = row[:tipo]
    patient.pain_duration = row[:duracion]
    patient.increases_with = row[:mayor]
    patient.decreases_with = row[:menor]
    patient.evaluation = row[:eva]
    patient.evera = EVERA_MAPPING[row[:evera]]
    patient.previous_tx = row[:tx_previo]
    patient.save(validate: false)
  end
end

SmarterCSV.process('tmp/Exploracion_Fisica.csv') do |chunk|
  chunk.each do |row|
    patient = Patient.find_by(id: row[:idpacientes])
    if patient.blank?
      not_found_patients << row[:idpacientes]
      next puts "Patient #{row[:idpacientes]} not found"
    end

    patient.neck = row[:cuello]
    patient.chest = row[:toraz]
    patient.spine = row[:columna]
    patient.extremities = row[:extremidades]
    patient.head = row[:cabeza]
    patient.blood_pressure = row[:ta]
    patient.abdomen = row[:abdomen]
    patient.heart_rate = row[:fc]
    patient.breath_rate = row[:fr]
    patient.weight = row[:peso]
    patient.height = row[:talla]
    patient.save(validate: false)
  end
end

SmarterCSV.process('tmp/Laboratorio_y_Gabinete.csv') do |chunk|
  chunk.each do |row|
    patient = Patient.find_by(id: row[:idpacientes])
    if patient.blank?
      not_found_patients << row[:idpacientes]
      next puts "Patient #{row[:idpacientes]} not found"
    end

    patient.laboratory = row[:laboratorio]
    patient.cabinet = row[:gabinete]
    patient.requested_studies = row[:estudios_solicitados]
    patient.consultations = row[:interconsultas]
    patient.save(validate: false)
  end
end

SmarterCSV.process('tmp/Tratamiento.csv') do |chunk|
  chunk.each do |row|
    patient = Patient.find_by(id: row[:idpacientes])
    if patient.blank?
      not_found_patients << row[:idpacientes]
      next puts "Patient #{row[:idpacientes]} not found"
    end

    date = if row[:fecha].present?
             Time.strptime(row[:fecha], '%m/%d/%y').to_date
           else
             patient.registered_at.to_date
           end
    consultation = Consultation.new(patient:)
    consultation.date = date
    consultation.procedure = row[:procedimiento]
    consultation.meds = row[:medicamentos]
    consultation.save(validate: false)
  end
end

puts "Not found patients: #{not_found_patients.uniq.size}"

CSV.open('tmp/broken_patients.csv', 'w') do |csv|
  csv << ['Id del paciente', 'Descripción del error']
  Patient.all.each do |patient|
    next if patient.valid?

    csv << [patient.id, patient.errors.full_messages]
  end
end
