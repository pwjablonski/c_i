class AddCloud9UsernameToStudents < ActiveRecord::Migration
  def change
      add_column :students, :cloud9_username, :string
  end
end
