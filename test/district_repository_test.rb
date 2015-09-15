require_relative '../lib/district_repository.rb'

class DistrictRepositoryTest < Minitest::Test
  attr_reader :district_repository
  def setup
    @district_repository = DistrictRepository.new
  end

  def test_has_list_of_districts
    skip
  end

  def test_can_import_districts_to_repository_from_file
    skip
  end

  def test_can_search_districts_by_name
    skip
  end

  def test_name_search_returns_district_object_if_name_found
    skip
  end

  def test_name_search_returns_nil_if_name_not_found
    skip
  end

  def test_can_search_districts_by_name_fragments
    skip
  end

  def test_search_by_name_fragments_returns_empty_array_if_no_matches
    skip
  end

end
