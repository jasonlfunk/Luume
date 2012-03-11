class AddInvoicedToLog < ActiveRecord::Migration
  def change
    add_column :logs, :invoiced, :boolean
  end
end
