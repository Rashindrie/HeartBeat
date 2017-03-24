class ChangeColumnTypeDoctor < ActiveRecord::Migration[5.0]
  def up
    remove_column("doctors","gender")
    add_column("doctors","gender", :boolean , :null => false)
  end

  def down
    remove_column("doctors","gender")
    add_column("doctors","gender", :integer , limit => 4, :null => false)
  end
end
