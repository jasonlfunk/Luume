# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120417003616) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "address"
    t.text     "comments"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
  end

  add_index "clients", ["user_id"], :name => "index_clients_on_user_id"

  create_table "invoice_entries", :force => true do |t|
    t.integer  "invoice_id"
    t.string   "title"
    t.text     "description"
    t.decimal  "hours",       :precision => 10, :scale => 2
    t.decimal  "rate",        :precision => 10, :scale => 2
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "invoice_entries", ["invoice_id"], :name => "index_invoice_entries_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.datetime "date"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invoices", ["project_id"], :name => "index_invoices_on_project_id"

  create_table "logs", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "task_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "invoiced"
    t.decimal  "billable",   :precision => 10, :scale => 1
    t.decimal  "actual",     :precision => 10, :scale => 1
  end

  add_index "logs", ["task_id"], :name => "index_logs_on_task_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start"
    t.date     "finish"
    t.decimal  "rate",                 :precision => 8, :scale => 2, :default => 75.0
    t.integer  "client_id"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
