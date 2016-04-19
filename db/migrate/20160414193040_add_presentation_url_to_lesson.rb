class AddPresentationUrlToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :presentation_url , :string
  end
end
