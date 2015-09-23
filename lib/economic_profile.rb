require_relative 'data_parser'

class EconomicProfile
  include CheckingValidData
  include FormattingData
  attr_reader :district_name, :data
  def initialize(district_name, parser)
    @district_name = district_name
    @parser        = parser
    @data          = parser.load_economic_profile_data
  end

  def free_or_reduced_lunch_by_year
    free_or_reduced_lunch = extract_poverty_level(free_reduced_lunch_data,
                                          "Eligible for Free or Reduced Lunch")
    percents_only = extract_data_format(free_or_reduced_lunch, "Percent")
    format_by_year(percents_only)
  end

  def free_or_reduced_lunch_in_year(year)
    return nil unless valid_year?(year)
    free_or_reduced_lunch_by_year[year]
  end

  def school_aged_children_in_poverty_by_year
    percents_only = extract_data_format(kids_in_poverty_data, "Percent")
    format_by_year(percents_only)
  end

  def school_aged_children_in_poverty_in_year(year)
    return nil unless valid_year?(year)
    school_aged_children_in_poverty_by_year[year] # this isn't getting called
  end

  def title_1_students_by_year
    format_by_year(title_1_data)
  end

  def title_1_students_in_year(year)
    return nil unless valid_year?(year)
    title_1_students_by_year[year]
  end

  def free_reduced_lunch_data
    pull_district_data(data[:economic_profile][:free_lunches])
  end

  def kids_in_poverty_data
    pull_district_data(data[:economic_profile][:poverty])
  end

  def title_1_data
    pull_district_data(data[:economic_profile][:title_one])
  end

  def extract_poverty_level(data_segment, level)
    data_segment.keep_if { |data| data[:poverty_level] == level }
  end
end
