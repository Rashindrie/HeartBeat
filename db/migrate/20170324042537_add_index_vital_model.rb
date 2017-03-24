class AddIndexVitalModel < ActiveRecord::Migration[5.0]
  def up
    add_index("vitals","patient_id", :name => "patientID")
  end

  def down
    remove_index("vitals", "patient_id")
  end
end
