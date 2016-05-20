class AddTrackIdToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :track_id , :string
  end
end
