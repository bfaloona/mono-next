require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init

task default: 'test'

desc 'Run all tests (including prod)'
task :testall => [:test, :prod]