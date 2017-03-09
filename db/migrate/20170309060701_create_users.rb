class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.integer :role, :limit => 1, :null => false
      t.integer :patient_id, :limit => 1
      t.integer :doctor_id, :limit => 1
      t.integer :staff_id, :limit => 1
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
