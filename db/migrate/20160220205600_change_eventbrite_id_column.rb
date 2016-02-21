class ChangeEventbriteIdColumn < ActiveRecord::Migration
  
      def change
          remove_column :events, :eventbrite_id
          add_column :events, :eb_event_id, :bigint
      end
  
end
