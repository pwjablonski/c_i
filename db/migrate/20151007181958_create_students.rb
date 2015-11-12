class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      
      t.string  :user_id
      
      t.integer :classroom_id
      
      t.string :name
      t.string :grade
      
      t.timestamps null: false
    end
  end
end
