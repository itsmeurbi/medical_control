# frozen_string_literal: true

# rubocop:disable Layout/LineLength
# converter_script.rb explicitly defined the records id and so the id sequence on Postges unsynced
# This script takes the last id in per collection and updates the senquence so we avoid already take id exceptions
sequence_name = ActiveRecord::Base.connection.execute("SELECT pg_get_serial_sequence('patients', 'id')").first['pg_get_serial_sequence']
max_id = ActiveRecord::Base.connection.execute('SELECT MAX(id) FROM patients').first['max'].to_i
next_id = max_id + 1
ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{sequence_name} RESTART WITH #{next_id}")

sequence_name = ActiveRecord::Base.connection.execute("SELECT pg_get_serial_sequence('consultations', 'id')").first['pg_get_serial_sequence']
max_id = ActiveRecord::Base.connection.execute('SELECT MAX(id) FROM consultations').first['max'].to_i
next_id = max_id + 1
ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{sequence_name} RESTART WITH #{next_id}")
# rubocop:enable Layout/LineLength
