class AddRegistrationIdToAttendanceData < ActiveRecord::Migration
  def change
      add_column :attendance_data, :registration_id, :integer
  end
end
