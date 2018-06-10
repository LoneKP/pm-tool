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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180610080329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.integer "harvest_project_id"
    t.string "project_name"
    t.string "client_name"
    t.integer "hours_sold_for"
    t.integer "total_time_hours"
    t.integer "programming_hours"
    t.integer "project_management_hours"
    t.integer "meetings_hours"
    t.integer "design_hours"
    t.integer "completion_percentage"
    t.datetime "project_start_date"
    t.datetime "project_end_date"
    t.integer "color_number"
    t.boolean "added_to_dashboard"
    t.boolean "archived"
    t.integer "work_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "risk_actions", force: :cascade do |t|
    t.string "risk"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
  end

  create_table "unadded_projects", force: :cascade do |t|
    t.string "project_name"
    t.string "client_name"
    t.integer "harvest_project_id"
  end

end
