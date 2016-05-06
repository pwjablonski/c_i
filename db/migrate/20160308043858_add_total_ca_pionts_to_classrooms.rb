class AddTotalCaPiontsToClassrooms < ActiveRecord::Migration
  def change
      add_column :classrooms, :ca_points , :integer
  end
end
