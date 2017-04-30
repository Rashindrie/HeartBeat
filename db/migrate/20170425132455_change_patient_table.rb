class ChangePatientTable < ActiveRecord::Migration[5.0]
  def up
    add_column("patients","registered","boolean", :default => true)
  end

  def down
    remove_column("patients", "registered")
  end
end
