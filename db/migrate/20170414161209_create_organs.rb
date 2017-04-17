class CreateOrgans < ActiveRecord::Migration[5.0]
  def up
    create_table :organs do |t|
      t.string :name, :null => false, :limit => 20
      t.boolean :living_donation, :null => false
      t.boolean :deceased_donation, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :organs
  end
end
