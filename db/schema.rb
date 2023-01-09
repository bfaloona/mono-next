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

ActiveRecord::Schema.define(version: 20221228071200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'accounts', force: true do |t|
    t.string 'name'
    t.string 'surname'
    t.string 'email'
    t.string 'crypted_password'
    t.string 'role'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'authors', force: true do |t|
    t.string 'name', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'genders', force: true do |t|
    t.string 'name', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'monologues', force: true do |t|
    t.integer 'play_id'
    t.string 'location', limit: 255
    t.string 'first_line', limit: 255
    t.text 'body'
    t.integer 'gender_id'
    t.string 'character', limit: 255
    t.string 'style', limit: 255
    t.string 'pdf_link', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'body_link', limit: 255
    t.integer 'intercut'
  end

  create_table 'plays', force: true do |t|
    t.integer 'author_id'
    t.string 'title', limit: 255
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'classification', limit: 255
  end

end
