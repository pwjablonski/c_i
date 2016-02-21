class AddPermissionUrlToEvent < ActiveRecord::Migration
  def change
       add_column :events, :permission_url, :string
  end
end
