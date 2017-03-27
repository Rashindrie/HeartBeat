class Addfullname < ActiveRecord::Migration[5.0]
  def up
    add_column("patients", "full_name", "string", :null => false)
    add_column("doctors", "full_name", "string", :null => false)
    add_column("staffs", "full_name", "string", :null => false)
  end

  def down
    remove_column("staffs","full_name")
    remove_column("doctors","full_name")
    remove_column("patients","full_name")
  end
end
