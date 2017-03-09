class CreatePatients < ActiveRecord::Migration[5.0]
  def up
    create_table :patients do |t|
      t.string :first_name, :null => false
      t.string :middle_name, :null => false
      t.string :last_name, :null => false
      t.boolean :gender, :null => false
      t.datetime :date_of_birth , :null => false
      t.string :telephone, :null => false
      t.string :email, :null => false, :limit => 40
      t.timestamps
    end
  end

  def down
    drop_table :patients
  end
end

