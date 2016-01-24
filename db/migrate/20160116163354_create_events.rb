class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :date
      t.string :location
      t.string :image_url
      t.integer :eventbrite_id
  
      t.timestamps null: false
    end
  end
end
