class AddTypeToEvents < ActiveRecord::Migration
  def change
       add_column :events, :registration_type , :string
       add_column :events, :event_type , :string
  end
end
