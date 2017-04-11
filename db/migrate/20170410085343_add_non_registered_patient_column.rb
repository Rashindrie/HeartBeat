class AddNonRegisteredPatientColumn < ActiveRecord::Migration[5.0]
  def up
    add_column("appointments","registered","boolean", :null => false)
  end

  def down
    remove_column("appointments", "registered")
  end
end
