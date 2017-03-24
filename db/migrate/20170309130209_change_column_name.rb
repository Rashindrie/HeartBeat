class ChangeColumnName < ActiveRecord::Migration[5.0]
  def up
    rename_column("doctor_types", "type", "speciality")
  end

  def down
    rename_column("doctor_types", "speciality", "type")
  end
end
