class ChangeColumnType < ActiveRecord::Migration[5.0]
  def up
    remove_column("patients", "date_of_birth")
    add_column("patients", "date_of_birth", :date ,:null =>false)
  end

  def down
    remove_column("patients", "date_of_birth")
    add_column("patients", "date_of_birth", :datetime ,:null =>false)
  end
end
