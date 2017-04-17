class DropOrgansPatients < ActiveRecord::Migration[5.0]
  def change
    drop_table :organs_patients
  end
end
