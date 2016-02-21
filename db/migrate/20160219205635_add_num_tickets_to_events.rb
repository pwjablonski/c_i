class AddNumTicketsToEvents < ActiveRecord::Migration
  def change
      add_column :events, :num_tickets, :integer
  end
end
