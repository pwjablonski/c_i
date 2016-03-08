class AddTotalCaPiontsToClassrooms < ActiveRecord::Migration
  def change
      add_column :classrooms, :ca_points , :string
  end
end
