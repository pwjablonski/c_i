class AddCredlyMemberIdToStudent < ActiveRecord::Migration
  def change
      add_column :students, :credly_member_id, :integer
  end
end
