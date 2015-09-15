require_relative '../lib/statewide_testing'

class StatewideTestingTest < Minitest::Test
  def setup
    @statewide_testing = StatewideTestingTest.new("Sample")
  end

  def test_is_associated_with_a_district
    skip
  end

end
