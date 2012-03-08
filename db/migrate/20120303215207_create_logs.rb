class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.datetime :start
      t.datetime :end
      t.references :task

      t.timestamps
    end
    add_index :logs, :task_id
  end
end
