class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :event_id
      t.bigint :eb_event_id
      t.bigint :eb_attendee_id
      t.integer :student_id
      t.string :status

      t.timestamps null: false
    end
    
  end
  
end
