class RemoveEmailPatientTable < ActiveRecord::Migration[5.0]
  def change
    remove_column("patients", "email")
  end
end
