class AddBillableToLog < ActiveRecord::Migration
  def change
    add_column :logs, :billable, :integer

  end
end
