class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.string :link_url
      t.string :resource_type

      t.timestamps null: false
    end
  end
end
