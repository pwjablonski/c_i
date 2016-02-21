class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :unit_id
      t.string :repo

      t.timestamps null: false
    end
  end
end
