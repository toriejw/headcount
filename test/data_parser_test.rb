require_relative '../lib/data_parser.rb'

class DataParserTest < Minitest::Test
  attr_reader :file_path
  def setup
    @file_path = File.expand_path('fixtures/Pupil enrollment.csv', __dir__)
  end

  def test_loads_district_names_from_file
    districts = DataParser.load_districts(file_path)
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], districts
  end

  def test_Colorado_not_included_when_districts_loaded
    districts = DataParser.load_districts(file_path)
    refute districts.include?("Colorado" || "colorado")
  end

  def test_can_load_districts_when_variable_order_changes
    new_file = File.expand_path('fixtures/Pupil enrollment modified.csv', __dir__)
    districts = DataParser.load_districts(new_file)
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], districts
  end

  def test_district_names_are_upcased_when_loaded
    new_file = File.expand_path('fixtures/Pupil enrollment modified.csv', __dir__)
    districts = DataParser.load_districts(new_file)
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], districts
  end
end
