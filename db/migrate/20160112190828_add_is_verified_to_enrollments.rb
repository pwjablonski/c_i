class AddIsVerifiedToEnrollments < ActiveRecord::Migration
  def change
      add_column :enrollments, :is_verified, :boolean, default: false
  end
end
