class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.datetime :begin
      t.datetime :finish
      t.integer :rate
      t.references :client

      t.timestamps
    end
    add_index :projects, :client_id
  end
end
