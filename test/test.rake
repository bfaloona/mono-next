require 'rake/testtask'

test_tasks = Dir['test/*/'].map do |d|
  File.basename(d) if File.basename(d) != 'prod'
end
test_tasks.compact!

test_tasks.each do |folder|
  Rake::TestTask.new("test:#{folder}") do |test|
    test.pattern = "test/#{folder}/**/*_test.rb"
    test.verbose = false
  end
end

Rake::TestTask.new('prod') do |test|
  test.description = 'Run production url and short url validation'
  test.pattern = 'test/prod/**/*_test.rb'
  test.verbose = false
end

desc 'Run test suite'
task 'test' => test_tasks.map { |f| "test:#{f}" }
