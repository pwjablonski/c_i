class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :tag_line
      t.string :description
      t.string :image_url
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
