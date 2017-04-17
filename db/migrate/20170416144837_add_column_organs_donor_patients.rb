class AddColumnOrgansDonorPatients < ActiveRecord::Migration[5.0]
  def up
    add_column("organs_donor_patients","category","boolean", :null => false)
  end

  def down
    remove_column("organs_donor_patients", "category")
  end
end
