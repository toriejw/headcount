require_relative '../lib/enrollment'

class EnrollmentTest < Minitest::Test
  attr_reader :enrollment
  def setup
    @enrollment = Enrollment.new("ACADEMY 20", DataParser.new)
  end

  def test_is_associated_with_a_district
    assert_equal "ACADEMY 20", enrollment.district_name
  end

  def test_has_data
    assert enrollment.data
  end

  def test_dropout_rate_in_year_returns_nil_if_invalid_year_given
    refute enrollment.dropout_rate_in_year(3000)
  end

  def test_can_return_dropout_rate_in_year
    assert_equal 0.004, enrollment.dropout_rate_in_year(2012)
  end

  def test_dropout_rate_in_year_truncated_at_3_decimals
    assert_equal 5, enrollment.dropout_rate_in_year(2011).to_s.size
  end

  def test_dropout_rate_by_gender_in_year_returns_nil_if_invalid_year_given
    refute enrollment.dropout_rate_by_gender_in_year(3000)
  end

  def test_can_return_dropout_rate_by_gender_in_year
    dropout_rates_by_gender = {:female => 0.004, :male => 0.004}
    assert_equal dropout_rates_by_gender, enrollment.dropout_rate_by_gender_in_year(2012)
  end

  def test_dropout_rate_by_gender_in_year_truncated_at_3_decimals
    assert_equal 5, enrollment.dropout_rate_by_gender_in_year(2011)[:male].to_s.size
  end

  def test_dropout_rate_by_race_in_year_returns_nil_if_invalid_year_given
    refute enrollment.dropout_rate_by_race_in_year(3000)
  end

  def test_can_return_dropout_rate_by_race_in_year
    dropout_rates_by_race = { :asian => 0.007,
                              :black => 0.002,
                              :pacific_islander => 0.000,
                              :hispanic => 0.006,
                              :native_american => 0.036,
                              :two_or_more => 0.000,
                              :white => 0.004
                            }
    assert_equal dropout_rates_by_race, enrollment.dropout_rate_by_race_in_year(2012)
  end

  def test_dropout_rate_by_race_in_year_truncated_at_3_decimals
    assert_equal 5, enrollment.dropout_rate_by_race_in_year(2012)[:asian].to_s.size
  end

  def test_dropout_for_race_or_ethnicity_returns_unknownrace_error_if_invalid_race_given
    assert_raises (UnknownRaceError::StandardError) { enrollment.dropout_rate_for_race_or_ethnicity(:asdfad) }
  end

  def test_can_return_dropout_rate_for_race_or_ethnicity
    dropout_rates_for_asians = { 2011 => 0.000,
                                 2012 => 0.007
                               }
    assert_equal dropout_rates_for_asians, enrollment.dropout_rate_for_race_or_ethnicity(:asian)
  end

  def test_dropout_rate_by_race_in_year_truncated_at_3_decimals
    assert_equal 5, enrollment.dropout_rate_for_race_or_ethnicity(:asian)[2012].to_s.size
  end

  def test_dropout_for_race_or_ethnicity_in_year_returns_unknownrace_error_if_invalid_race_given
    assert_raises (UnknownRaceError::StandardError) { enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asdfad) }
  end

  def test_dropout_for_race_or_ethnicity_in_year_returns_nil_if_invalid_year_given
    refute enrollment.dropout_rate_for_race_or_ethnicity_in_year(:black, 1900)
  end

  def test_can_return_dropout_rate_for_race_or_ethnicity_in_year
    assert_equal 0.007, enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
  end

  def test_dropout_rate_by_race_in_year_truncates_at_3_decimals
    assert_equal 5, enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012).to_s.size
  end

  def test_can_return_grad_rates_by_year
    grad_rates = { 2010 => 0.895,
                   2011 => 0.895,
                   2012 => 0.889,
                   2013 => 0.913,
                   2014 => 0.898,
                 }
    assert_equal grad_rates, enrollment.graduation_rate_by_year
  end

  def test_graduation_rate_by_year_truncates_at_3_decimals
    assert_equal 5, enrollment.graduation_rate_by_year[2012].to_s.size
  end

  def test_grad_rates_in_year_returns_nil_if_invalid_year_given
    refute enrollment.graduation_rate_in_year(1900)
  end

  def test_can_return_grad_rates_in_year
    assert_equal 0.913, enrollment.graduation_rate_in_year(2013)
  end

  def test_graduation_rate_in_year_truncates_at_3_decimals
    assert_equal 5, enrollment.graduation_rate_in_year(2012).to_s.size
  end

  def test_can_return_kindergarten_participation_by_year
    kindergarten_participation = { 2007 => 0.391,
                                   2006 => 0.353,
                                   2005 => 0.267,
                                   2004 => 0.302,
                                   2008 => 0.384,
                                   2009 => 0.390,
                                   2010 => 0.436,
                                   2011 => 0.489,
                                   2012 => 0.478,
                                   2013 => 0.487,
                                   2014 => 0.490
                                 }
    assert_equal kindergarten_participation, enrollment.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_by_year_truncates_at_3_decimals
    assert_equal 0.353, enrollment.kindergarten_participation_by_year[2006]
  end

  def test_kindergarten_participation_in_year_returns_nil_if_invalid_year_given
    refute enrollment.kindergarten_participation_in_year(1900)
  end

  def test_can_return_kindergarten_participation_in_year
    assert_equal 0.436, enrollment.kindergarten_participation_in_year(2010)
  end

  def test_kindergarten_participation_in_year_truncates_at_3_decimals
    assert_equal 0.353, enrollment.kindergarten_participation_in_year(2006)
  end

  def test_can_return_online_participation_by_year
    online_participation = { 2011 => 33,
                             2012 => 35,
                             2013 => 341,
                            }
    assert_equal online_participation, enrollment.online_participation
  end

  def test_online_participation_by_year_truncates_at_3_decimals
    assert_equal 35, enrollment.online_participation[2012]
  end

  def test_online_participation_in_year_returns_nil_if_invalid_year_given
    refute enrollment.online_participation_in_year(1900)
  end

  def test_can_return_online_participation_in_year
    assert_equal 35, enrollment.online_participation_in_year(2012)
  end

  def test_online_participation_in_year_returns_single_integer
    assert_equal 341, enrollment.online_participation_in_year(2013)
  end

  def test_can_return_participation_by_year
    participation = { 2009 => 22620,
                      2010 => 23119,
                      2011 => 23657,
                      2012 => 23973,
                      2013 => 24481,
                      2014 => 24578,
                    }
    assert_equal participation, enrollment.participation_by_year
  end

  def test_participation_by_year_returns_single_integer
    assert_equal 23973, enrollment.participation_by_year[2012]
  end

  def test_participation_in_year_returns_nil_if_invalid_year_given
    refute enrollment.participation_in_year(1900)
  end

  def test_can_return_participation_in_year
    assert_equal 23973, enrollment.participation_in_year(2012)
  end

  def test_participation_in_year_returns_single_integer
    assert_equal 24481, enrollment.participation_in_year(2013)
  end

  def test_participation_by_race_or_ethnicity_returns_unknownrace_error_if_invalid_race_given
    assert_raises (UnknownRaceError::StandardError) { enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asdfad) }
  end

  def test_can_return_participation_by_race
    asian_participation = { 2007 => 0.05,
                            2008 => 0.054,
                            2009 => 0.055,
                            2010 => 0.04,
                            2011 => 0.036,
                            2012 => 0.038,
                            2013 => 0.038,
                            2014 => 0.037
                          }
    assert_equal asian_participation, enrollment.participation_by_race_or_ethnicity(:asian)
  end

  def test_participation_by_race_or_ethnicity_truncates_at_3_decimals
    assert_equal 0.038, enrollment.participation_by_race_or_ethnicity(:asian)[2012]
  end

  def test_participation_by_race_in_year_returns_nil_if_invalid_year_given
    refute enrollment.participation_by_race_or_ethnicity_in_year(1900)
  end

  def test_can_return_participation_by_race_in_year
    participation_by_race_in_2012 = { :asian => 0.038,
                                      :black => 0.031,
                                      :hispanic => 0.121,
                                      :pacific_islander => 0.004,
                                      :white => 0.750
                                    }
    assert_equal participation_by_race_in_2012, enrollment.participation_by_race_or_ethnicity_in_year(2012)
  end

  def test_participation_by_race_or_ethnicity_in_year_truncates_at_3_decimals
    assert_equal 0.004, enrollment.participation_by_race_or_ethnicity_in_year(2012)[:pacific_islander]
  end

  ###########

  def test_can_special_education_by_year
    skip
    special_education = { 2009 => 0.075,
                          2010 => 0.078,
                          2011 => 0.072,
                          2012 => 0.071,
                          2013 => 0.070,
                          2014 => 0.068,
                        }
    assert_equal special_education, enrollment.special_education_by_year
  end

  def test_can_special_education_by_year_truncates_at_3_decimals
    skip
    assert_equal 0.071, enrollment.special_education_by_year[2012]
  end
end
