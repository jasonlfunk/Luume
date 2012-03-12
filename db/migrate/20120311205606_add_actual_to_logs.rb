class AddActualToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :actual, :integer

  end
end
