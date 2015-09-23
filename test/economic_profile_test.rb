require_relative '../lib/economic_profile'

class EconomicProfileTest < MiniTest::Test
  attr_reader :profile
  def setup
    @profile = EconomicProfile.new("ACADEMY 20", DataParser.new)
  end

  def test_is_associated_with_a_district
    assert_equal "ACADEMY 20", profile.district_name
  end

  ###########

  def test_can_return_free_or_reduced_lunch_data_by_year
    free_or_reduced_lunch = { 2014 => 0.127,
                              2012 => 0.125,
                              2011 => 0.119,
                              2010 => 0.113,
                              2009 => 0.103,
                              2013 => 0.131,
                              2008 => 0.093,
                              2007 => 0.08,
                              2006 => 0.072,
                              2005 => 0.058,
                              2004 => 0.059,
                              2003 => 0.06,
                              2002 => 0.048,
                              2001 => 0.047,
                              2000 => 0.04
                            }
    assert_equal free_or_reduced_lunch, profile.free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_luncy_by_year_truncates_at_3_decimals
    assert_equal 0.127, profile.free_or_reduced_lunch_by_year[2014]
  end

  def test_free_or_reduced_lunch_in_year_returns_nil_if_invalid_year_given
    refute profile.free_or_reduced_lunch_in_year(1900)
  end

  def test_can_return_free_or_reduced_lunch_in_year
    assert_equal 0.125, profile.free_or_reduced_lunch_in_year(2012)
  end

  def test_free_or_reduced_lunch_in_year_truncates_at_3_decimals
    assert_equal 0.131, profile.free_or_reduced_lunch_in_year(2013)
  end

  ###########

  def test_can_return_school_aged_children_in_poverty_by_year
    children_in_poverty = { 1995 => 0.032,
                               1997 => 0.035,
                               1999 => 0.032,
                               2000 => 0.031,
                               2001 => 0.029,
                               2002 => 0.033,
                               2003 => 0.037,
                               2004 => 0.034,
                               2005 => 0.042,
                               2006 => 0.036,
                               2007 => 0.039,
                               2008 => 0.044,
                               2009 => 0.047,
                               2010 => 0.057,
                               2011 => 0.059,
                               2012 => 0.064,
                               2013 => 0.048,
                             }
    assert_equal children_in_poverty, profile.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_by_year_truncates_at_3_decimals
    assert_equal 0.048, profile.school_aged_children_in_poverty_by_year[2013]
  end

  def test_school_aged_children_in_poverty_in_year_returns_nil_if_invalid_year_given
    refute profile.school_aged_children_in_poverty_in_year(1900)
  end

  def test_can_return_school_aged_children_in_poverty_in_year
    assert_equal 0.064, profile.school_aged_children_in_poverty_in_year(2012)
  end

  def test_school_aged_children_in_poverty_in_year_truncates_at_3_decimals
    assert_equal 0.048, profile.school_aged_children_in_poverty_in_year(2013)
  end

  ###########

  def test_can_return_title_1_students_by_year
    title_1_students = { 2009 => 0.014,
                         2011 => 0.011,
                         2012 => 0.01,
                         2013 => 0.012,
                         2014 => 0.027
                       }
    assert_equal title_1_students, profile.title_1_students_by_year
  end

  def test_title_1_students_by_year_truncates_at_3_decimals
    assert_equal 0.012, profile.title_1_students_by_year[2013]
  end

  def test_title_1_students_in_year_returns_nil_if_invalid_year_given
    refute profile.title_1_students_in_year(1900)
  end

  def test_can_return_title_1_students_in_year
    assert_equal 0.011, profile.title_1_students_in_year(2011)
  end

  def test_title_1_students_in_year_truncates_at_3_decimals
    assert_equal 0.014, profile.title_1_students_in_year(2009)
  end
end
