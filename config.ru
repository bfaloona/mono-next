# frozen_string_literal: true

require 'rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'pg'
require 'rack/logger'
require 'yaml'
require 'bundler'
Bundler.require



# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

ENV['RACK_ENV'] ||= 'test'
require './app'

use Rack::Logger if ['test', 'development'].include?(ENV['RACK_ENV'])

run Sinatra::Application

