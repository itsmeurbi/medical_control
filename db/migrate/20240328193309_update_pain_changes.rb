class UpdatePainChanges < ActiveRecord::Migration[7.0]
  def up
    change_table :patients, bulk: true do |t|
      t.remove :pain_last_time, type: :string
      t.string :increases_with
      t.string :decreases_with
    end
  end
end
