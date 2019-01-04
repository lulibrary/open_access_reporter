require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib)

require 'open_access_reporter'

def config
  {
    unpaywall_email: ENV['UNPAYWALL_EMAIL']
  }
end