class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      
      t.integer  :user_id
      
      t.integer :school_id
      t.integer :classroom_id

      
      t.string :first_name
      t.string :last_name
      t.string :profile_name
      
      
      t.string :profile_pic_url, default: "http://riskid.nl/assets/testimonials/user-3995d1ed5f9b6ea6ef9c7bc9ead47415.jpg" , null: false
      t.text :about_me
      t.string :github_username
      t.string :codecademy_username
      
      
      t.timestamps null: false
    end
  end
end
