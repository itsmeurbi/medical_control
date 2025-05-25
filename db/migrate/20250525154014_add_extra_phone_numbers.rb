class AddExtraPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    change_table :patients, bulk: true do |t|
      t.string :cellphone_number_two
      t.string :cellphone_number_three
    end
  end
end
