class CreateInvoiceEntries < ActiveRecord::Migration
  def change
    create_table :invoice_entries do |t|
      t.references :invoice
      t.string :title
      t.text :description
      t.decimal :hours, :precision => 10, :scale => 2
      t.decimal :rate, :precision => 10, :scale => 2

      t.timestamps
    end
    add_index :invoice_entries, :invoice_id
  end
end
