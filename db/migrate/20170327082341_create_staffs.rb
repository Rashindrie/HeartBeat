class CreateStaffs < ActiveRecord::Migration[5.0]
  def up
    create_table :staffs do |t|
      t.string :full_name, :null => false
      t.string :first_name , :null => false
      t.string :middle_name
      t.string :last_name , :null => false
      t.boolean :gender, :null =>false
      t.string :telephone , :null => false
      t.string :email , :null => false
      t.timestamps
    end
  end

  def down
    drop_table :staffs
  end
end