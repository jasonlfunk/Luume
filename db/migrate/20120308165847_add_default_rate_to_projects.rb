class AddDefaultRateToProjects < ActiveRecord::Migration
  def change
    change_column :projects, :rate, :decimal, :precision => 8, :scale => 2, :default => 75.00
  end
end
