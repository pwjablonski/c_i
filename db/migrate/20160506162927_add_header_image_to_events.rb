class AddHeaderImageToEvents < ActiveRecord::Migration
  def change
    add_column :events, :header_image , :string
  end
end
