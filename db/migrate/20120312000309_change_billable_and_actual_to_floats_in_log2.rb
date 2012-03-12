class ChangeBillableAndActualToFloatsInLog2 < ActiveRecord::Migration
  def up
    change_column :logs, :actual, :decimal, :precision => 10, :scale => 1
    change_column :logs, :billable, :decimal, :precision => 10, :scale => 1
  end

  def down
    change_column :logs, :actual, :integer
    change_column :logs, :billable, :integer
  end
end
