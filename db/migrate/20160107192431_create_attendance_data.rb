class CreateAttendanceData < ActiveRecord::Migration
  def change
    create_table :attendance_data do |t|
      t.integer :enrollment_id
      t.integer :attendance_list_id
      t.boolean :present

      t.timestamps null: false
    end
  end
end
