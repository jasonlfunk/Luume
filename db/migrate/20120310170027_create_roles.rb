class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role
      t.references :user

      t.timestamps
    end
    add_index :roles, :user_id
  end
end
