class ChangeColumnNameOfStaffMember < ActiveRecord::Migration
  def change
    rename_column :staff_members, :short_date, :start_date
  end
end
