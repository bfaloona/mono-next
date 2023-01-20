# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
# ENV['RACK_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "test"
APP_ROOT = File.expand_path("..", __dir__)

# require the controller(s)
# says that app.rb is in the root
Dir.glob(File.join(APP_ROOT, "app", "*.rb")).each { |file| require file }

# require the model(s)
# models stored in lib/
Dir.glob(File.join(APP_ROOT, "lib", "*.rb")).each { |file| require file }

# require database configurations
# the database setup files that were just made in config/
require File.join(APP_ROOT, "config", "database")

# require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

# require_relative '../app/app'
# require_relative '../app/admin/models/account'
