require 'codeclimate-test-reporter'
CodeClimate::TestReporter.configuration.git_dir = '.'
CodeClimate::TestReporter.start

require 'simplecov'
if ENV['COVERAGE']
  SimpleCov.start do
    add_filter '/test/'
  end
  SimpleCov.minimum_coverage 98
end

require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new(color: true)
  Minitest::Reporters::SpecReporter.new
)

require 'ap'
require 'simple_json_api'
require 'test_setup'
require 'minitest-match_json'
Minitest::MatchJson.configure do |config|
  config.format = :color
end
