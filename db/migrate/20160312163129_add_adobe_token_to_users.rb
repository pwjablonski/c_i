class AddAdobeTokenToUsers < ActiveRecord::Migration
  def change
      add_column :users, :adobe_token , :string
  end
end
