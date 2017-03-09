class CreateDoctorTypes < ActiveRecord::Migration[5.0]
  def up
    create_table :doctor_types do |t|
      t.string :type
      t.timestamps
    end
  end

  def down
    drop_table :doctor_types
  end
end
