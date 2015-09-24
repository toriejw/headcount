require_relative '../lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :ha
  def setup
    directory = File.expand_path 'fixtures', __dir__
    dr = DistrictRepository.new(DataParser.new(directory))
    @ha = HeadcountAnalyst.new(dr)
  end

  def test_initializes_with_a_repo
    assert ha.repo
  end

  def test_can_return_top_statewide_testing_year_over_year_growth_for_top_district
    skip
    expected = ['the top district name', 0.123]
    assert_equal expected, ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:subject => :math)
  end

  def test_can_return_top_statewide_testing_year_over_year_growth_for_top_few_districts
    skip
    expected = [['top district name', growth_1],['second district name', growth_2],['third district name', growth_3]]
    assert_equal expected, ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:top => 3, :subject => :math)
  end

  def test_can_return_top_statewide_testing_year_over_year_growth_for_top_district_across_all_subjects
    skip
    expected = ['the top district name', 0.123]
    assert_equal expected, ha.top_statewide_testing_year_over_year_growth_in_3rd_grade
  end

  def test_can_return_top_statewide_testing_year_over_year_growth_for_top_district_across_all_subjects_for_given_weighting
    skip
    expected = ['the top district name', 0.123]
    assert_equal expected, ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:weighting => {:math => 0.5, :reading => 0.5, :writing => 0.0})
  end

  def test_top_statewide_testing_year_over_year_growth_for_top_district_across_all_subjects_for_given_weighting_checks_weights_add_to_1
    skip
  end
end
