class RenameEvaraToEvera < ActiveRecord::Migration[7.0]
  def up
    rename_column :patients, :evara, :evera
  end

  def down
    rename_column :patients, :evera, :evara
  end
end
