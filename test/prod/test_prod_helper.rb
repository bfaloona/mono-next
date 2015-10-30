require 'cucumber'
require 'rest-client'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

def prepend_protocol url
  return url.match(/^https?\:\/\//) ? url : 'http://' + url
end