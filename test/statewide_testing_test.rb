require_relative '../lib/statewide_testing'

class StatewideTestingTest < Minitest::Test
  attr_reader :statewide_testing
  def setup
    @statewide_testing = StatewideTesting.new("ACADEMY 20", DataParser.new)
  end

  def test_is_associated_with_a_district
    assert_equal "ACADEMY 20", statewide_testing.district_name
  end

  def test_has_data
    assert statewide_testing.data
  end

  def test_proficiency_in_each_subject_by_grade_returns_unkowndata_error_if_wrong_argument_entered
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_by_grade(2) }
  end

  def test_can_return_proficiency_in_each_subject_by_grade
    grade_three_proficiency = {2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
                               2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
                               2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
                               2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
                               2012 => {:reading => 0.870, :math => 0.830, :writing => 0.655},
                               2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
                               2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
                              }
    assert_equal grade_three_proficiency, statewide_testing.proficient_by_grade(3)
  end

  def test_proficiency_in_each_subject_by_race_returns_unkowndata_error_if_wrong_argument_entered
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_by_race_or_ethnicity(:octopus) }
  end

  def test_can_return_proficiency_in_each_subject_by_race_or_ethnicity
    asian_proficiency = {2011 => {:math => 0.816, :reading => 0.897, :writing => 0.826},
                         2012 => {:math => 0.818, :reading => 0.893, :writing => 0.808},
                         2013 => {:math => 0.805, :reading => 0.901, :writing => 0.810},
                         2014 => {:math => 0.800, :reading => 0.855, :writing => 0.789},
                        }
    assert_equal asian_proficiency, statewide_testing.proficient_by_race_or_ethnicity(:asian)
  end

  def test_proficiency_in_subject_by_grade_in_year_returns_unkowndata_error_if_wrong_arguments_entered
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_grade_in_year(:math, 5, 2011) }
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_grade_in_year(:math, 8, 1900) }
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_grade_in_year(:gym, 8, 2011) }
  end

  def test_can_return_proficiency_in_subject_by_grade_in_year
    grade_three_math_proficiency_in_2008 = statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
    assert_equal 0.857, grade_three_math_proficiency_in_2008
  end

  def test_proficient_for_subject_by_race_in_year_returns_unknowndata_error_if_wrong_arguments_entered
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_race_in_year(:math, :octopus, 2011) }
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 1900) }
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_race_in_year(:gym, :asian, 2011) }
  end

  def test_can_return_proficiency_for_subject_by_race_in_year
    asian_math_scores_in_2012 = statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
    assert_equal 0.818, asian_math_scores_in_2012
  end

  def test_proficient_for_subject_in_year_returns_unknowndata_error_if_wrong_arguments_entered
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_in_year(:history, 2011) }
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_in_year(:math, 1900) }
  end

  def test_can_return_proficiency_for_subject_in_year
    expected_math_scores_in_2012 = {3 => 0.830, 8 => 0.681}
    actual_math_scores_in_2012   = statewide_testing.proficient_for_subject_in_year(:math, 2012)
    assert_equal expected_math_scores_in_2012, actual_math_scores_in_2012
  end

  def test_proficient_by_grade_returns_numbers_truncated_at_3_decimals
    data_length = statewide_testing.proficient_by_grade(3)[2014][:reading].to_s.size
    assert_equal 5, data_length
  end

  def test_by_race_or_ethnicity_returns_numbers_truncated_at_3_decimals
    data_length = statewide_testing.proficient_by_race_or_ethnicity(:black)[2012][:math].to_s.size
    assert_equal 5, data_length
  end

  def test_proficient_for_subject_by_grade_in_year_returns_numbers_truncated_at_3_decimals
    data_length = statewide_testing.proficient_for_subject_by_grade_in_year(:reading, 8, 2011).to_s.size
    assert_equal 5, data_length
  end

  def test_can_return_proficiency_for_subject_by_race_in_year_returns_numbers_truncated_at_3_decimals
    data_length = statewide_testing.proficient_for_subject_by_race_in_year(:math, :black, 2012).to_s.size
    assert_equal 5, data_length
  end

  def test_proficiency_for_subject_in_year_returns_numbers_truncated_at_3_decimals
    data_length = statewide_testing.proficient_for_subject_in_year(:math, 2011)[3].to_s.size
    assert_equal 5, data_length
  end

end
