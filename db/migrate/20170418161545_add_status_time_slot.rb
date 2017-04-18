class AddStatusTimeSlot < ActiveRecord::Migration[5.0]
  def up
    add_column("time_slots","status","boolean", :null => false)
  end

  def down
    remove_column("time_slots", "status")
  end
end
