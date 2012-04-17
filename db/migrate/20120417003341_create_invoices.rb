class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :date
      t.references :project

      t.timestamps
    end
    add_index :invoices, :project_id
  end
end
