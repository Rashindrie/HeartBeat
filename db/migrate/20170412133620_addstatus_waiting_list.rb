class AddstatusWaitingList < ActiveRecord::Migration[5.0]
  def up
    add_column("waiting_lists","status","boolean", :null => false)
  end

  def down
    remove_column("waiting_lists", "status")
  end
end
