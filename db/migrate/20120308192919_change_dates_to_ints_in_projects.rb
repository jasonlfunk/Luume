class ChangeDatesToIntsInProjects < ActiveRecord::Migration
  def up
    change_column :projects, :start, :integer 
    change_column :projects, :finish, :integer 
  end

  def down
    change_column :projects, :start, :date
    change_column :projects, :finish, :date
  end
end
