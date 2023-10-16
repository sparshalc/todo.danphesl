class AddAssignedStatusToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :assigned_status, :boolean, default: false
  end
end
