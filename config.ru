# frozen_string_literal: true

require 'rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'yaml'
require 'bundler'
Bundler.require

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

require 'pg'

require './app'

run Sinatra::Application
