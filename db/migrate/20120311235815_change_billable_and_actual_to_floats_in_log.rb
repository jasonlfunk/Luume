class ChangeBillableAndActualToFloatsInLog < ActiveRecord::Migration
  def up
    change_column :logs, :actual, :decimal, :precision => 1, :scale => 10
    change_column :logs, :billable, :decimal, :precision => 1, :scale => 10
  end

  def down
    change_column :logs, :actual, :integer
    change_column :logs, :billable, :integer
  end
end
