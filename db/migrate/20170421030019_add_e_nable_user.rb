class AddENableUser < ActiveRecord::Migration[5.0]
  def up
    add_column("users","status","boolean", :null => false, :default => true)
  end

  def down
    remove_column("users", "status")
  end
end
