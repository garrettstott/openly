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

ActiveRecord::Schema.define(version: 2021_08_09_232207) do

  create_table "addresses", force: :cascade do |t|
    t.integer "addressable_id", null: false
    t.string "addressable_type", null: false
    t.string "line1"
    t.string "line2"
    t.string "city", null: false
    t.string "region", null: false
    t.string "country", null: false
    t.string "postal_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_id"], name: "index_addresses_on_addressable_id"
    t.index ["addressable_type"], name: "index_addresses_on_addressable_type"
  end

  create_table "chiefs", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "created_by", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "title", null: false
    t.boolean "current", default: true, null: false
    t.boolean "approved", default: false, null: false
    t.boolean "denied", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_chiefs_on_company_id"
    t.index ["created_by"], name: "index_chiefs_on_created_by"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.integer "founded"
    t.string "website"
    t.string "employee_count"
    t.string "industry"
    t.text "about"
    t.integer "created_by", null: false
    t.boolean "approved", default: false, null: false
    t.boolean "denied", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by"], name: "index_companies_on_created_by"
  end

  create_table "employment_companies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.boolean "current", default: true, null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.string "job_title", null: false
    t.integer "salary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_employment_companies_on_company_id"
    t.index ["user_id"], name: "index_employment_companies_on_user_id"
  end

  create_table "job_listings", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "job_title"
    t.string "salary"
    t.text "description"
    t.integer "job_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_job_listings_on_company_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "message"
    t.integer "style", null: false
    t.integer "created_by", null: false
    t.integer "noteable_id"
    t.string "noteable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by"], name: "index_notes_on_created_by"
    t.index ["noteable_id"], name: "index_notes_on_noteable_id"
    t.index ["noteable_type"], name: "index_notes_on_noteable_type"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "review_id", null: false
    t.integer "style", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_ratings_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.integer "chief_id"
    t.text "message", null: false
    t.text "previous_message"
    t.integer "thumbs", default: 0, null: false
    t.float "overall_rating", default: 0.0, null: false
    t.boolean "approved", default: false, null: false
    t.boolean "denied", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chief_id"], name: "index_reviews_on_chief_id"
    t.index ["company_id"], name: "index_reviews_on_company_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "gender", null: false
    t.string "race", null: false
    t.string "orientation", null: false
    t.boolean "person_of_color", null: false
    t.boolean "denied", default: false, null: false
    t.boolean "approved", default: true, null: false
    t.string "username", null: false
    t.boolean "admin", default: false, null: false
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chiefs", "companies"
  add_foreign_key "employment_companies", "companies"
  add_foreign_key "employment_companies", "users"
  add_foreign_key "job_listings", "companies"
  add_foreign_key "ratings", "reviews"
  add_foreign_key "reviews", "chiefs"
  add_foreign_key "reviews", "companies"
  add_foreign_key "reviews", "users"
end
