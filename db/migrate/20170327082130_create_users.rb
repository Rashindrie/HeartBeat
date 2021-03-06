class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.integer :role, :limit => 1, :null => false
      t.integer :patient_id
      t.integer :doctor_id
      t.integer :staff_id
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end