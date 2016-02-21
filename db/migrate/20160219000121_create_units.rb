class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.integer :track_id

      t.timestamps null: false
    end
  end
end
