class CreateDoctors < ActiveRecord::Migration[5.0]
  def up
    create_table :doctors do |t|
      t.integer :doctor_type_id
      t.string :first_name , :null => false
      t.string :middle_name
      t.string :last_name , :null => false
      t.integer :gender, :limit => 1 , :null =>false
      t.string :telephone , :null => false
      t.string :email , :null => false
      t.integer :doctor_type_id
      t.timestamps
    end
  end

  def down
    drop_table :doctors
  end
end
