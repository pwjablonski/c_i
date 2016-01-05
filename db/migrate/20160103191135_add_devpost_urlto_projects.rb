class AddDevpostUrltoProjects < ActiveRecord::Migration
  def change
     
          add_column :projects, :devpost_url, :string

  end
end
