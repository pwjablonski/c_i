class AddSignatureRequestIdToRegistrations < ActiveRecord::Migration
  def change
      add_column :registrations, :signature_request_id , :string
  end
end
