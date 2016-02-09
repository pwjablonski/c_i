class AddCaClassIdToClassrooms < ActiveRecord::Migration
  def change
      add_column :classrooms, :ca_class_id, :string
  end
end
