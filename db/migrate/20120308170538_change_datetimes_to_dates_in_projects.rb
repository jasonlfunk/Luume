class ChangeDatetimesToDatesInProjects < ActiveRecord::Migration
  def up
    change_column :projects, :begin, :date
    change_column :projects, :finish, :date
  end

  def down
    change_column :projects, :begin, :datetime
    change_column :projects, :finish, :datetime
  end
end
