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

ActiveRecord::Schema.define(version: 20160727113106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "ltree"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "additionals", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: true do |t|
    t.string  "name"
    t.string  "body"
    t.integer "id_question"
    t.integer "user_id"
  end

  create_table "average_caches", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calendar_dates", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "time"
    t.date     "date"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "count"
    t.decimal  "total_price"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id", using: :btree
  add_index "cart_items", ["user_id"], name: "index_cart_items_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "logo_image"
    t.string   "slug"
    t.integer  "total_count_products"
    t.integer  "sid"
    t.boolean  "is_leaf"
    t.integer  "level"
    t.integer  "parent_id"
    t.ltree    "path"
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["product_id"], name: "index_comments_on_product_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "configures", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_of_week", default: 0
    t.time     "time"
  end

  create_table "countries", force: true do |t|
    t.string   "alpha2"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  create_table "delivery_couriers", force: true do |t|
    t.integer  "order_id"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivery_couriers", ["order_id"], name: "index_delivery_couriers_on_order_id", using: :btree

  create_table "delivery_posts", force: true do |t|
    t.integer  "order_id"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivery_posts", ["order_id"], name: "index_delivery_posts_on_order_id", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["product_id"], name: "index_favorites_on_product_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "last_products", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "last_products", ["product_id"], name: "index_last_products_on_product_id", using: :btree
  add_index "last_products", ["user_id"], name: "index_last_products_on_user_id", using: :btree

  create_table "main_orders", force: true do |t|
    t.integer  "state",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meeting_deliveries", force: true do |t|
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meeting_item_id"
  end

  add_index "meeting_deliveries", ["meeting_item_id"], name: "index_meeting_deliveries_on_meeting_item_id", using: :btree
  add_index "meeting_deliveries", ["order_id"], name: "index_meeting_deliveries_on_order_id", using: :btree

  create_table "meeting_items", force: true do |t|
    t.text     "location"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.integer  "admin_user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "main_order_id"
    t.date     "meeting_date"
    t.text     "registered_time"
  end

  add_index "meetings", ["main_order_id"], name: "index_meetings_on_main_order_id", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "price"
    t.integer  "count"
    t.integer  "state",      default: 0
    t.integer  "product_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.integer  "row_id"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "orders", force: true do |t|
    t.decimal  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state",         default: 0
    t.integer  "user_id"
    t.integer  "payment_type",  default: 0
    t.integer  "delivery",      default: 0
    t.integer  "meeting_id"
    t.integer  "main_order_id"
    t.decimal  "paid_amount"
  end

  create_table "overall_averages", force: true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_params", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_params", ["product_id"], name: "index_product_params_on_product_id", using: :btree

  create_table "product_pictures", force: true do |t|
    t.string   "url"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_pictures", ["product_id"], name: "index_product_pictures_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "subcategory_id"
    t.string   "depth"
    t.string   "width"
    t.string   "height"
    t.integer  "sid"
    t.integer  "country_id"
    t.integer  "color_id"
    t.integer  "trademark_id"
    t.boolean  "k_min"
    t.boolean  "is_hit"
    t.integer  "min_qty"
    t.integer  "photo_count"
    t.string   "balance_text"
    t.string   "box_size_text"
    t.string   "materials_text"
    t.string   "size_text"
    t.string   "unit"
    t.string   "image"
    t.float    "price"
    t.integer  "weight"
    t.string   "certificate_type"
    t.string   "box_type"
    t.integer  "new_type_id"
  end

  create_table "questions", force: true do |t|
    t.string   "name"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "reminders", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.date     "start_date"
    t.date     "stop_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "row_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "row_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "row_comments", ["row_id"], name: "index_row_comments_on_row_id", using: :btree
  add_index "row_comments", ["user_id"], name: "index_row_comments_on_user_id", using: :btree

  create_table "row_items", force: true do |t|
    t.integer  "count"
    t.integer  "row_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_item_id"
  end

  add_index "row_items", ["row_id"], name: "index_row_items_on_row_id", using: :btree
  add_index "row_items", ["user_id"], name: "index_row_items_on_user_id", using: :btree

  create_table "rows", force: true do |t|
    t.integer  "current_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state",         default: 0
    t.integer  "product_id"
    t.integer  "min_count"
    t.integer  "main_order_id"
  end

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree

  create_table "trademarks", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "name"
    t.integer  "phone"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
