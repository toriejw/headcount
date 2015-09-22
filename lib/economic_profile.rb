require_relative 'data_parser'

class EconomicProfile

  attr_reader :district_name, :data
  def initialize(district_name, parser)
    @district_name ||= district_name
    @parser          = parser
    @data          ||= parser.load_enrollment_data
  end

  def free_or_reduced_lunch_by_year
    #     This method returns a hash with years as keys and an floating point three-significant digits representing a percentage.
    #
    # economic_profile.free_or_reduced_lunch_by_year
    # # => { 2000 => 0.020,
    # #      2001 => 0.024,
    # #      2002 => 0.027,
    # #      2003 => 0.030,
    # #      2004 => 0.034,
    # #      2005 => 0.058,
    # #      2006 => 0.041,
    # #      2007 => 0.050,
    # #      2008 => 0.061,
    # #      2009 => 0.070,
    # #      2010 => 0.079,
    # #      2011 => 0.084,
    # #      2012 => 0.125,
    # #      2013 => 0.091,
    # #      2014 => 0.087,
    # #    }
  end

  def free_or_reduced_lunch_in_year(year)
    #     This method takes one parameter:
    #
    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.
    #
    # The method returns a single three-digit floating point percentage.
    #
    # enrollment.remediation_in_year(2012) # => 0.125
  end

  def school_aged_children_in_poverty_in_year

    # This method returns a hash with years as keys and an floating point three-significant digits representing a percentage. It returns an empty hash if the district's data is not in the CSV.

    # Example:

    # economic_profile.school_aged_children_in_poverty_in_year
    # => { 1995 => 0.032,
    #      1997 => 0.035,
    #      1999 => 0.032,
    #      2000 => 0.031,
    #      2001 => 0.029,
    #      2002 => 0.033,
    #      2003 => 0.037,
    #      2004 => 0.034,
    #      2005 => 0.042,
    #      2006 => 0.036,
    #      2007 => 0.039,
    #      2008 => 0.044,
    #      2009 => 0.047,
    #      2010 => 0.057,
    #      2011 => 0.059,
    #      2012 => 0.064,
    #      2013 => 0.048,
    #    }
  end

  def school_aged_children_in_poverty_in_year(year)

    # This method takes one parameter:
    #
    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.
    #
    # The method returns a single three-digit floating point percentage.
    #
    # Example:
    #
    # economic_profile.school_aged_children_in_poverty_in_year(2012) # => 0.064
  end

  def title_1_students_by_year

    # This method returns a hash with years as keys and an floating point three-significant digits representing a percentage. It returns an empty hash if the district's data is not in the CSV.
    #
    # Example:
    #
    # economic_profile.title_1_students_by_year
    # # => {2009 => 0.014, 2011 => 0.011, 2012 => 0.01, 2013 => 0.012, 2014 => 0.027}
  end

  def title_1_students_in_year(year)

    # This method takes one parameter:
    #
    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.
    #
    # The method returns a single three-digit floating point percentage.
    #
    # Example:
    #
    # economic_profile.title_1_students_in_year(2012) # => 0.01
  end
end
