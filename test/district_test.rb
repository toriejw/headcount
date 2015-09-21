require_relative '../lib/district'

class DistrictTest < Minitest::Test
  attr_reader :district

  def setup
    @district = District.new("sample", DataParser.new)
  end

  def test_has_a_name_that_is_upcased
    assert_equal "SAMPLE", district.name
  end

  def test_can_create_instance_of_statewide_testing
    assert_equal StatewideTesting, @district.statewide_testing.class
  end

  def test_can_create_instance_of_enrollment
    assert_equal Enrollment, @district.enrollment.class
  end
end
