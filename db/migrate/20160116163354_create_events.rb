class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :image_url
      t.string :eventbrite_id
  
      t.timestamps null: false
    end
  end
end
