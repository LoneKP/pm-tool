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

ActiveRecord::Schema.define(version: 20190422111239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "harvest_integrations", force: :cascade do |t|
    t.integer "harvest_account_id"
    t.string "access_token"
    t.bigint "organisation_id"
    t.index ["organisation_id"], name: "index_harvest_integrations_on_organisation_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "token"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organisation_id"
    t.bigint "user_id"
    t.index ["organisation_id"], name: "index_invitations_on_organisation_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "organisation_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.boolean "closed"
    t.float "work_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "evaluation"
    t.bigint "organisation_id"
    t.index ["organisation_id"], name: "index_projects_on_organisation_id"
  end

  create_table "responsibilities", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_responsibilities_on_project_id"
    t.index ["user_id"], name: "index_responsibilities_on_user_id"
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
    t.integer "year"
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

  create_table "time_trackings", force: :cascade do |t|
    t.datetime "date"
    t.float "total_hours"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_hours_design"
    t.float "total_hours_programming"
    t.float "total_hours_project_management"
    t.float "total_hours_meetings"
    t.float "total_hours_daily_standup"
    t.index ["project_id"], name: "index_time_trackings_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "access_token"
    t.bigint "organisation_id"
    t.string "password_digest"
    t.index ["organisation_id"], name: "index_users_on_organisation_id"
  end

  add_foreign_key "harvest_integrations", "organisations"
  add_foreign_key "invitations", "organisations"
  add_foreign_key "invitations", "users"
  add_foreign_key "projects", "organisations"
  add_foreign_key "users", "organisations"
end
