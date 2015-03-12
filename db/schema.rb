# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150312120810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "billing_contact"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "company_identification_number"
    t.string   "tax_identification_number"
    t.string   "vat_identification_number"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "billing_infos", ["user_id"], name: "index_billing_infos_on_user_id", using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "commission", precision: 8, scale: 2
    t.integer  "lang",                               default: 0
  end

  create_table "links", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.string   "url"
    t.string   "code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "open_actions", force: :cascade do |t|
    t.integer  "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sell_actions", force: :cascade do |t|
    t.integer  "link_id"
    t.string   "code"
    t.string   "email"
    t.decimal  "price",          precision: 8, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.decimal  "commission",     precision: 8, scale: 2
    t.datetime "approved_at"
    t.datetime "charged_at"
    t.datetime "balanced_at"
    t.datetime "claimed_at"
    t.datetime "paid_at"
    t.integer  "payment_method"
    t.string   "iban"
    t.string   "swift"
    t.string   "paypal"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                   default: 0
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
