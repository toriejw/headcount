# The instance of this object represents data from the following files:
#
# 3rd grade students scoring proficient or above on the CSAP_TCAP.csv
# 4th grade students scoring proficient or above on the CSAP_TCAP.csv
# 8th grade students scoring proficient or above on the CSAP_TCAP.csv
# Average proficiency on the CSAP_TCAP by race_ethnicity_Math.csv
# Average proficiency on the CSAP_TCAP by race_ethnicity_Reading.csv
# Average proficiency on the CSAP_TCAP by race_ethnicity_Writing.csv
# .initialize(name)
#
# An instance of this class can be initialized by supplying the name of the district
# which is then used to find the matching data in the data files.
#

class StatewideTesting
  attr_reader :district_name
  def initialize(district_name)
    @district_name = district_name
  end

  def proficient_by_grade(grade)
    # grade as an integer from the following set: [3, 4, 8]
    # A call to this method with an unknown grade should raise a UnknownDataError.
    # The method returns a hash grouped by year referencing percentages by subject
    # all as three digit floats.
    # The method returns a hash grouped by year referencing percentages by subject
    # all as three digit floats.

    # Example:
    # statewide_testing.proficient_by_grade(3)
    # # => {2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
    #       2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
    #       2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
    #      }
  end


  def proficient_by_race_or_ethnicity(race)
    # race is a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # A call to this method with an unknown race should raise a UnknownDataError.
    # The method returns a hash grouped by race referencing percentages by subject all as truncated three digit floats.
    #
    # Example:
    #
    # statewide_testing.proficient_by_race_or_ethnicity(:asian)
    # # => {2011 => {:math => 0.816, :reading => 0.897, :writing => 0.826},
    #       2012 => {:math => 0.818, :reading => 0.893, :writing => 0.808},
    #       2013 => {:math => 0.805, :reading => 0.901, :writing => 0.810},
    #       2014 => {:math => 0.800, :reading => 0.855, :writing => 0.789},
    #      }
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # grade as an integer from the following set: [3, 4, 8]
    # year as an integer for any year reported in the data
    # A call to this method with any invalid parameter (like subject of :science) should raise a UnknownDataError.
    #
    # The method returns a truncated three-digit floating point number representing a percentage.
    #
    # Example:
    #
    # statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008) # => 0.857
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    # subject as a symbol from the following set: [:math, :reading, :writing]
    # race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # year as an integer for any year reported in the data
    # A call to this method with any invalid parameter (like subject of :history) should raise a UnknownDataError.
    #
    # The method returns a truncated three-digit floating point number representing a percentage.
    #
    # Example:
    # statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2012) # => 0.818
  end

  def proficient_for_subject_in_year(subject, year)
    # subject is a symbol from the following set: [:math, :reading, :writing]
    # year is an integer for any year reported in the data
    # A call to this method with any invalid parameter (like subject of :history) should raise a UnknownDataError.
    #
    # The method returns a truncated three-digit floating point number representing a percentage.
    #
    # Example:
    # statewide_testing.proficient_for_subject_in_year(:math, 2012) # => 0.680
  end

end
