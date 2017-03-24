class CreateVitals < ActiveRecord::Migration[5.0]
  def up
    create_table :editVital do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.float :height
      t.float :weight
      t.float :bmi
      t.float :blood_group
      t.float :temp
      t.float :pulse
      t.float :res_rate
      t.float :bld_pressure

      t.timestamps
    end
  end

  def down
      drop_table :editVital
  end
end
