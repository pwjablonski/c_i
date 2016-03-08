class AddEventIdToAttendanceList < ActiveRecord::Migration
  def change
       add_column :attendance_lists, :event_id, :integer
  end
end
