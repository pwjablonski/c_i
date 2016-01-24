class CreateAttendanceLists < ActiveRecord::Migration
  def change
    create_table :attendance_lists do |t|
      t.integer :classroom_id
      t.date :date

      t.timestamps null: false
    end
  end
end
