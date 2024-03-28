class RemovePatientAge < ActiveRecord::Migration[7.0]
  def change
    remove_column :patients, :age, :integer
  end
end
