class AddStatusOrganRequesterPatient < ActiveRecord::Migration[5.0]
  def up
    add_column("organs_requester_patients","status","boolean", :null => false)
  end

  def down
    remove_column("organs_requester_patients", "status")
  end
end
