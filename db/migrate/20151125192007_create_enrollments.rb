class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.integer :classroom_id
      t.timestamps null: false
    end
  end
end
