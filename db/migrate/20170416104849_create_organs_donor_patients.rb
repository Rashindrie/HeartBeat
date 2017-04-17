class CreateOrgansDonorPatients < ActiveRecord::Migration[5.0]
  def change
    create_table :organs_donor_patients, :id => false do |t|
      t.references :organ, :patient
    end

    add_index :organs_donor_patients, [:organ_id, :patient_id],
              name: "organs_donor_patients_index",
              unique: true
  end
end
