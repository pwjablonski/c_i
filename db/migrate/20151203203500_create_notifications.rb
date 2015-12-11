class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :message
      t.date :date_posted
      t.integer :classroom_id

      t.timestamps null: false
    end
  end
end
