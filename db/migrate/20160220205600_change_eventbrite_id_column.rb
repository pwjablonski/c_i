class ChangeEventbriteIdColumn < ActiveRecord::Migration
  
      def change
          add_column :events, :eb_event_id, :bigint
      end
  
end
