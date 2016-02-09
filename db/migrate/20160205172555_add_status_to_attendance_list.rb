class AddStatusToAttendanceList < ActiveRecord::Migration
  def change
      add_column :attendance_lists, :status, :string, default: "open"
  end
end
