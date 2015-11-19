class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :school_name
      t.string :school_address

      t.timestamps null: false
    end
  end
end
