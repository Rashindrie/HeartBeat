class AddAppointmentStatus < ActiveRecord::Migration[5.0]
  def up
    add_column("appointments","status","boolean", :null => false)
  end

  def down
    remove_column("appointments", "status")
  end
end
