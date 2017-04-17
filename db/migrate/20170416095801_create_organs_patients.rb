class CreateOrgansPatients < ActiveRecord::Migration[5.0]
  def up
    create_table :organs_patients do |t|
      t.integer :organ_id
      t.integer :patient_id
      t.timestamps
      end
  end

  def down
    drop_table :organs_patients
  end
end
