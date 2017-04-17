class ChangeStatusrganRequesterPatient < ActiveRecord::Migration[5.0]
  def up
    remove_column("organs_requester_patients", "status")
    add_column("organs_requester_patients","status","integer", :null => false)
  end

  def down
    remove_column("organs_requester_patients", "status")
    add_column("organs_requester_patients","status","boolean", :null => false)
  end
end
