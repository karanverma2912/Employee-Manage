# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_12_30_070126) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "audit_logs", force: :cascade do |t|
    t.string "action"
    t.bigint "auditable_id", null: false
    t.string "auditable_type", null: false
    t.string "changed_by"
    t.jsonb "changes_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_audit_logs_on_auditable"
  end

  create_table "budgets", force: :cascade do |t|
    t.decimal "allocated_amount"
    t.datetime "created_at", null: false
    t.bigint "department_id", null: false
    t.integer "fiscal_year"
    t.decimal "spent_amount"
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_budgets_on_department_id"
  end

  create_table "certifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "issuing_body"
    t.string "name"
    t.datetime "updated_at", null: false
    t.date "valid_from"
    t.date "valid_to"
  end

  create_table "certifications_employees", force: :cascade do |t|
    t.bigint "certification_id", null: false
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.datetime "updated_at", null: false
    t.index ["certification_id"], name: "index_certifications_employees_on_certification_id"
    t.index ["employee_id"], name: "index_certifications_employees_on_employee_id"
  end

  create_table "departments", force: :cascade do |t|
    t.decimal "budget_allocation"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "employee_profiles", force: :cascade do |t|
    t.string "address"
    t.string "blood_group"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.bigint "employee_id", null: false
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_profiles_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "department_id", null: false
    t.string "email"
    t.string "first_name"
    t.date "hire_date"
    t.boolean "is_active"
    t.string "job_title"
    t.string "last_name"
    t.bigint "manager_id"
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["manager_id"], name: "index_employees_on_manager_id"
  end

  create_table "performances", force: :cascade do |t|
    t.text "comments"
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.integer "rating"
    t.date "review_date"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_performances_on_employee_id"
  end

  create_table "project_assignments", force: :cascade do |t|
    t.date "assigned_date"
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.date "end_date"
    t.integer "hours_allocated"
    t.bigint "project_id", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_project_assignments_on_employee_id"
    t.index ["project_id"], name: "index_project_assignments_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.decimal "budget"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.string "name"
    t.date "start_date"
    t.string "status"
    t.datetime "updated_at", null: false
  end

  create_table "salaries", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.string "currency"
    t.date "effective_from"
    t.date "effective_to"
    t.bigint "employee_id", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  add_foreign_key "budgets", "departments"
  add_foreign_key "certifications_employees", "certifications"
  add_foreign_key "certifications_employees", "employees"
  add_foreign_key "employee_profiles", "employees"
  add_foreign_key "employees", "departments"
  add_foreign_key "employees", "employees", column: "manager_id"
  add_foreign_key "performances", "employees"
  add_foreign_key "project_assignments", "employees"
  add_foreign_key "project_assignments", "projects"
  add_foreign_key "salaries", "employees"
end
