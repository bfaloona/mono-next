require 'rake/testtask'

test_tasks = Dir['test/*/'].map do |d|
  File.basename(d) if File.basename(d) != 'prod'
end
test_tasks.compact!

test_tasks.each do |folder|
  Rake::TestTask.new("test:#{folder}") do |test|
    test.pattern = "test/#{folder}/**/*_test.rb"
    test.verbose = true
  end
end

Rake::TestTask.new('prod') do |test|
  test.description = 'Run production url and short url validation'
  test.pattern = 'test/prod/**/*_test.rb'
  test.verbose = false
end

desc "Run application test suite"
task 'test' => test_tasks.map { |f| "test:#{f}" }

desc "POST json to /api/monologues"
task :curl_post do
  `curl -v -X POST -d '{"username":"xyz","password":"xyz"}' http://localhost:3000/api/monologues`
end
