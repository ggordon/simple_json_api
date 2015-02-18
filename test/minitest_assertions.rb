require 'diffy'
Diffy::Diff.default_format = :color
require 'minitest/assertions'

module Minitest::Assertions
  #
  #  Fails unless +expected and +actual have the same items.
  #
  def assert_match_json(expected, actual)
    compare_json(expected, actual)
  end

  private

  # Helper to highlight diffs between two json strings
  def compare_json(expected_json, actual_json)
    actual_pretty = JSON.pretty_generate(JSON.parse(actual_json))
    expected_pretty = JSON.pretty_generate(JSON.parse(expected_json))
    diff =  Diffy::Diff.new(expected_pretty, actual_pretty)

    if diff.to_s.strip.empty?
      pass "JSON matched"
    else
      puts "\n#{diff}\n"
      flunk 'JSON did not match'
    end
  end
end

require 'minitest/spec'

module Minitest::Expectations
  #
  #  Fails unless the subject and parameter are equivalent JSON
  #
  String.infect_an_assertion :assert_match_json, :must_match_json
end


