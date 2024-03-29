# # This file is auto-generated from the current state of the database. Instead
# # of editing this file, please use the migrations feature of Active Record to
# # incrementally modify your database, and then regenerate this schema definition.
# #
# # This file is the source Rails uses to define your schema when running `bin/rails
# # db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# # be faster and is potentially less error prone than running all of your
# # migrations from scratch. Old migrations may fail to apply correctly if those
# # migrations use external dependencies or application code.
# #
# # It's strongly recommended that you check this file into your version control system.

# ActiveRecord::Schema[7.1].define(version: 2024_01_11_223832) do
#   # These are extensions that must be enabled in order to support this database
#   enable_extension "plpgsql"

#   create_table "active_storage_attachments", force: :cascade do |t|
#     t.string "name", null: false
#     t.string "record_type", null: false
#     t.bigint "record_id", null: false
#     t.bigint "blob_id", null: false
#     t.datetime "created_at", null: false
#     t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
#     t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
#   end

#   create_table "active_storage_blobs", force: :cascade do |t|
#     t.string "key", null: false
#     t.string "filename", null: false
#     t.string "content_type"
#     t.text "metadata"
#     t.string "service_name", null: false
#     t.bigint "byte_size", null: false
#     t.string "checksum"
#     t.datetime "created_at", null: false
#     t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
#   end

#   create_table "active_storage_variant_records", force: :cascade do |t|
#     t.bigint "blob_id", null: false
#     t.string "variation_digest", null: false
#     t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
#   end

#   create_table "bookings", force: :cascade do |t|
#     t.date "pick_up"
#     t.date "drop_off"
#     t.string "status"
#     t.string "final_price"
#     t.bigint "user_id", null: false
#     t.bigint "closet_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["closet_id"], name: "index_bookings_on_closet_id"
#     t.index ["user_id"], name: "index_bookings_on_user_id"
#   end

#   create_table "closets", force: :cascade do |t|
#     t.string "name"
#     t.string "location"
#     t.string "features"
#     t.string "accessibility"
#     t.string "state"
#     t.string "availability"
#     t.string "status"
#     t.bigint "user_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.float "latitude"
#     t.float "longitude"
#     t.index ["user_id"], name: "index_closets_on_user_id"
#   end

#   create_table "items", force: :cascade do |t|
#     t.string "name"
#     t.string "item_type"
#     t.string "fragility"
#     t.string "state"
#     t.string "size"
#     t.string "sell_price"
#     t.string "status"
#     t.bigint "user_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.bigint "booking_id"
#     t.index ["booking_id"], name: "index_items_on_booking_id"
#     t.index ["user_id"], name: "index_items_on_user_id"
#   end

#   create_table "users", force: :cascade do |t|
#     t.string "email", default: "", null: false
#     t.string "encrypted_password", default: "", null: false
#     t.string "first_name", default: "", null: false
#     t.string "last_name", default: "", null: false
#     t.string "phone_number", default: "", null: false
#     t.string "location", default: "", null: false
#     t.string "role", default: "", null: false
#     t.string "payment_method", default: "", null: false
#     t.string "reset_password_token"
#     t.datetime "reset_password_sent_at"
#     t.datetime "remember_created_at"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.boolean "admin", default: false, null: false
#     t.index ["email"], name: "index_users_on_email", unique: true
#     t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
#   end

#   add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
#   add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
#   add_foreign_key "bookings", "closets"
#   add_foreign_key "bookings", "users"
#   add_foreign_key "closets", "users"
#   add_foreign_key "items", "bookings"
#   add_foreign_key "items", "users"
# end


require 'faker'
require "open-uri"


owner = User.create!(
  email: "owner@test.com",
  password: "123456",
  role: "Owner",
  first_name: "Owner",
  last_name: "Test",
  phone_number: "1234567890",
  location: "Toronto"
)

host = User.create!(
  email: "host@test.com",
  password: "123456",
  role: "Host",
  first_name: "Host",
  last_name: "Test",
  phone_number: "12345623222",
  location: "Toronto"
)

5.times do |i|
  closet = Closet.new(
    name: "Closet #{i + 1}",
    location: "Toronto",
    features: "Shelves",
    accessibility: "Private",
    status: "available",
    user: host
  )
  file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")
  closet.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  closet.save!
  puts "Closet #{i} created"
end


5.times do |i|
  item = Item.new(
    name: "Item #{i + 1}",
    item_type: Item::ITEM_TYPE.sample,
    fragility: Item::FRAGILITY.sample,
    size: Item::SIZE.sample,
    status: "available",
    user: owner)
  file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")
  item.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  item.save!
  puts "Item #{i} created"
end
