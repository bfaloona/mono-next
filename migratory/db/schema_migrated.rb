
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

# Enable the Postgresql extension
enable :sessions
enable :method_override

# Define the schema for the database
ActiveRecord::Schema.define(version: 20100519065234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Create a table for accounts
  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  # Create a table for authors
  create_table "authors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  # Create a table for genders
  create_table "genders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  # Create a table for monologues
  create_table "monologues", force: :cascade do |t|
    t.integer  "play_id"
    t.string   "location",   limit: 255
    t.string   "first_line", limit: 255
    t.text     "body"
    t.integer  "gender_id"
    t.string   "character",  limit: 255
    t.string   "style",      limit: 255
    t.string   "pdf_link",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "body_link",  limit: 255
    t.integer  "intercut"
  end

  # Create a table for plays
  create_table "plays", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "title",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "classification", limit: 255
  end

end