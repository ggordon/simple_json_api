require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

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
require 'diffy'

# Helper to highlight diffs between two json strings
#   compare_json(actual_projects, expected_projects.to_json)
def compare_json(actual_json, expected_json)
  actual_pretty = JSON.pretty_generate(JSON.parse(actual_json))
  expected_pretty = JSON.pretty_generate(JSON.parse(expected_json))
  diff =  Diffy::Diff.new(actual_pretty, expected_pretty)
  puts "\n#{diff}\n" unless diff.to_s.empty?
end
