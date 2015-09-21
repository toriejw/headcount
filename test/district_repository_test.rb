require_relative '../lib/district_repository.rb'

# don't use fixtures?

class DistrictRepositoryTest < Minitest::Test
  attr_reader :dr, :file_path
  def setup
    @dr = DistrictRepository.new
    @file_path = File.expand_path('fixtures/Pupil enrollment.csv', __dir__)
    dr.load(file_path)
  end

  def test_has_list_of_districts
    assert dr.districts
  end

  def test_has_data
    assert dr.data
  end

  def test_can_import_districts_to_repository_from_file
    dr.load(file_path)
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], dr.districts
  end

  def test_can_search_districts_by_name
    district = dr.find_by_name("ADAMS COUNTY 14")
    assert_equal "ADAMS COUNTY 14", district.name
  end

  def test_name_search_returns_district_object_if_name_found
    district = dr.find_by_name("ADAMS COUNTY 14")
    assert_equal District, district.class
  end

  def test_name_search_returns_nil_if_name_not_found
    district = dr.find_by_name("Colorado")
    assert_equal nil, district
  end

  def test_name_search_is_case_insensitive
    district = dr.find_by_name("adams county 14")
    assert_equal "ADAMS COUNTY 14", district.name
  end

  def test_can_search_districts_by_name_fragments
    result = dr.find_all_matching("ADAMS")
    assert_equal ["ADAMS COUNTY 14"], result
  end

  def test_search_by_name_fragments_returns_all_matches
    result = dr.find_all_matching("A")
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], result
  end

  def test_search_by_name_fragments_is_case_insensitive
    result = dr.find_all_matching("a")
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], result
  end

  def test_search_by_name_fragments_returns_empty_array_if_no_matches
    result = dr.find_all_matching("adakdfjas;lkdfj")
    assert_equal [], result
  end
end
