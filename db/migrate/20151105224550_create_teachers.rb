class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
        
        t.integer :user_id
        
        t.string :first_name
        t.string :last_name
        t.string :profile_name


        t.string :profile_pic_url
        t.text :about_me
        t.string :github_username
        t.string :codecademy_username


      t.timestamps null: false
    end
  end
end
