class CreateCaData < ActiveRecord::Migration
  def change
    create_table :ca_data do |t|
      t.integer :total_points
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
