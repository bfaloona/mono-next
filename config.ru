# frozen_string_literal: true

require 'rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'pg'
require 'yaml'
require 'bundler'
Bundler.require

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

ENV['RACK_ENV'] ||= 'test'
require './app'

run Sinatra::Application

