class RemoveRegisteredAppWlTable < ActiveRecord::Migration[5.0]
  def change
    remove_column("appointments", "registered")
    remove_column("waiting_lists", "registered")
  end
end
