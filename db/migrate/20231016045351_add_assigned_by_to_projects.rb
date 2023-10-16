class AddAssignedByToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :assigned_by, :integer
  end
end
