class AddExtraPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :cellphone_number_2, :string
    add_column :patients, :cellphone_number_3, :string
  end
end
