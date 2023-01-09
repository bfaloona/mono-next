ENV['RACK_ENV'] ||= 'development'

require 'sinatra/activerecord/rake'
require 'rake/testtask'
require 'minitest/test_task'
Minitest::TestTask.create

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.verbose = false
  t.test_files = FileList['test/*_test.rb']
  t.warning = false
end

test_tasks = Dir['test/*/'].map do |d|
  case File.basename(d)
  when 'prod'
    nil
  else
    File.basename(d)
  end
end
test_tasks.compact!

test_tasks.each do |folder|
  Rake::TestTask.new("test:#{folder}") do |test|
    test.pattern = "test/#{folder}/**/*_test.rb"
    test.verbose = false
  end
end

# Rake::TestTask.new('prod') do |test|
#   test.description = 'Run production url and short url validation'
#   test.pattern = 'test/prod/**/*_test.rb'
#   test.verbose = false
# end

# desc "Run application test suite"
# task 'test' => test_tasks.map { |f| "test:#{f}" }

desc 'POST json to /search'
task :test_post do
  `curl -v -X POST -d '{"query":"z"}' -H "Accept: text/html" http://localhost:3000/search`
end

task :default => :test

namespace :db do
  task :load_config do
    require_relative 'app/app'
  end
end