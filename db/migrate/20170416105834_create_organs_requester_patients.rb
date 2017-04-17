class CreateOrgansRequesterPatients < ActiveRecord::Migration[5.0]

  def change
    create_table :organs_requester_patients, :id => false do |t|
      t.references :organ, :patient
      t.integer :doctor_id
    end

    add_index :organs_requester_patients, [:organ_id, :patient_id],
              name: "organs_requester_patients_index",
              unique: true
  end

end
