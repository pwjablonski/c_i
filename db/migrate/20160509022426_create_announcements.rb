class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :message
      t.integer :classroom_id
      t.string :subject

      t.timestamps null: false
    end
  end
end
