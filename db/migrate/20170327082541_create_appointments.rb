class CreateAppointments < ActiveRecord::Migration[5.0]
  def up
    create_table :appointments do |t|
      t.integer :time_slot_id
      t.integer :patient_id

      t.timestamps
    end
  end

  def down
    drop_table :appointments

  end
end