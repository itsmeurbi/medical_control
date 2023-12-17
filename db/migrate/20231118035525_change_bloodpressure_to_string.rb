class ChangeBloodpressureToString < ActiveRecord::Migration[7.0]
  def up
    change_column :patients, :blood_pressure, :string
  end

  def down
    change_column :patients, :blood_pressure, :integer
  end
end
