class OrganType < ActiveRecord::Migration[5.0]
  def up
    add_column("organs","category","boolean", :null => false)
  end

  def down
    remove_column("organs", "category")
  end
end
