class AddCapercentcompleteToStudents < ActiveRecord::Migration
 
  def change
    add_column :students, :capercentcomplete, :string
  end

end
