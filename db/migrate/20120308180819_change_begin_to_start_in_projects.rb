class ChangeBeginToStartInProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :begin
    add_column :projects, :start, :date
  end

  def down
    remove_column :projects, :start
    add_column :projects, :begin, :date
  end
end
