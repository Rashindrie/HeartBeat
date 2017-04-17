class CreateVisits < ActiveRecord::Migration[5.0]
  def up
    create_table :visits do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.string :problems_complaints
      t.string :diagnosis
      t.string :drugs
      t.string :remarks

      t.timestamps
    end
  end

  def down
    drop_table :visits
  end
end
