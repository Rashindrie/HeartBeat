class AddregisteredWaitingList < ActiveRecord::Migration[5.0]
  def up
      remove_column("waiting_lists", "status")
      add_column("waiting_lists","registered","boolean", :null => false)
  end

  def down
    remove_column("waiting_lists", "registered")
    add_column("waiting_lists","status","boolean", :null => false)
  end
end
