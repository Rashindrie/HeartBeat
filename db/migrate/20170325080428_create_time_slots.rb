class CreateTimeSlots < ActiveRecord::Migration[5.0]
  def up
    create_table :time_slots do |t|
      t.date :app_date
      t.time :from_time
      t.time :to_time
      t.integer :doctor_id
      t.integer :staff_id
      t.timestamps
    end
  end

  def down
    drop_table :time_slots
  end
end
