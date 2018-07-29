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

ActiveRecord::Schema.define(version: 20180729200334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.integer "harvest_project_id"
    t.string "project_name"
    t.string "client_name"
    t.float "hours_sold_for"
    t.float "total_time_hours"
    t.float "programming_hours"
    t.float "project_management_hours"
    t.float "meetings_hours"
    t.float "design_hours"
    t.float "completion_percentage"
    t.datetime "project_start_date"
    t.datetime "project_end_date"
    t.integer "color_number"
    t.boolean "added_to_dashboard"
    t.boolean "archived"
    t.float "work_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "evaluation"
  end

  create_table "revenue_months", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "month"
    t.integer "completion_percentage"
    t.float "hours_sold_for"
    t.float "total_time_hours"
    t.float "progressed_hourly_rate"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_revenue_months_on_project_id"
  end

  create_table "risk_actions", force: :cascade do |t|
    t.string "risk"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.float "work_hours"
    t.float "completion_percentage"
    t.float "total_time_hours"
  end

end
