 # The instance of this object represents data from the following files:
#
# Dropout rates by race and ethnicity.csv
# High school graduation rates.csv
# Kindergartners in full-day program.csv
# Online pupil enrollment.csv
# Pupil enrollment by race_ethnicity.csv
# Pupil enrollment.csv
# Special education.csv

class Enrollment
  attr_reader :district_name
  def initialize(district_name)
    @district_name = district_name
  end

  def dropout_rate_in_year(year)

  end
#
# This method takes one parameter:
#
# year as an integer for any year reported in the data
# A call to this method with any unknown year should return nil.
#
# The method returns a truncated three-digit floating point number representing a percentage.
#
# Example:
#
# enrollment.dropout_rate_in_year(2012) # => 0.680
  def dropout_rate_by_gender_in_year(year)

  end
#
# This method takes one parameter:
#
# year as an integer for any year reported in the data
# A call to this method with any unknown year should return nil.
#
# The method returns a hash with genders as keys and three-digit floating point number representing a percentage.
#
# Example:
#
# enrollment.dropout_rate_by_gender_in_year(2012)
# # => {:female => 0.002, :male => 0.002}
  def dropout_rate_by_race_in_year(year)

  end
#
# This method takes one parameter:
#
# year as an integer for any year reported in the data
# A call to this method with any unknown year should return nil.
#
# The method returns a hash with race markers as keys and a three-digit floating point number representing a percentage.
#
# Example:
#
# enrollment.dropout_rate_by_race_in_year(2012)
# # => {
#   :asian => 0.001,
#   :black => 0.001,
#   :pacific_islander => 0.001,
#   :hispanic => 0.001,
#   :native_american => 0.001,
#   :two_or_more => 0.001,
#   :white => 0.001
# }
  def dropout_rate_for_race_or_ethnicity(race)

  end
#
# This method takes one parameter:
#
# race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
# A call to this method with any unknown race should raise an UnknownRaceError.
#
# The method returns a hash with years as keys and a three-digit floating point number representing a percentage.
#
# Example:
#
# enrollment.dropout_rate_for_race_or_ethnicity(:asian)
# # => {
#   2011 => 0.047,
#   2012 => 0.041
# }
  def dropout_rate_for_race_or_ethnicity_in_year(race, year)

  end
#
# This method takes two parameters:
#
# race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
# year as an integer for any year reported in the data
# A call to this method with any unknown year should return nil.
#
# The method returns a truncated three-digit floating point number representing a percentage.
#
# Example:
#
# enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012) # => 0.001
  def graduation_rate_by_year

  end
#
# This method returns a truncated three-digit floating point number representing a percentage.
#
# Example:
#
# enrollment.graduation_rate_by_year
# # => {2010 => 0.895,
#       2011 => 0.895,
#       2012 => 0.889,
#       2013 => 0.913,
#       2014 => 0.898,
#      }
  def graduation_rate_in_year(year)

  end
#
# This method takes one parameter:
#
# year as an integer for any year reported in the data
# A call to this method with any unknown year should return nil.
#
# The method returns a truncated three-digit floating point number representing a percentage.
#
# Example:
#
# enrollment.graduation_rate_in_year(2010) # => 0.895
  def kindergarten_participation

  end

  def kindergarten_participation_in_year(year)

  end

  def online_participation

  end

  def online_participation_in_year(year)

  end

  def participation

  end

  def participation_in_year(year)

  end

  def participation_by_race_or_ethnicity

  end

  def participation_by_race_or_ethnicity_in_year(year)

  end

  def special_education

  end

  def special_education_in_year(year)

  end

  def remediation

  end

  def remediation_in_year(year)

  end
end
