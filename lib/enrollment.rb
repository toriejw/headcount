require_relative 'errors'
require_relative 'checking_valid_data'
require_relative 'formatting_data'
require_relative 'data_parser' # DELETE THIS LINE - NOT NEEDED IN TESTS

class Enrollment
  attr_reader :district_name, :data
  include CheckingValidData
  include FormattingData

  def initialize(district_name, parser)
    @district_name = district_name
    @parser        = parser
    @data          = parser.load_enrollment_data
  end

  def dropout_rate_in_year(year)
    return nil unless valid_year?(year)
    data_by_district          = dropout_rates_data_for_district
    data_by_district_and_race = pull_data_by_category(data_by_district, "All Students")
    data_by_year              = group_by_year(data_by_district_and_race)
    extract_data_point_for(year, data_by_year)
  end

  def dropout_rate_by_gender_in_year(year)
    return nil unless valid_year?(year)  ## this is repeated - way to return from this method via another method?
    data_by_district    = dropout_rates_data_for_district
    data_by_male        = pull_data_by_category(data_by_district, "Male Students")
    data_by_female      = pull_data_by_category(data_by_district, "Female Students")
    male_data_by_year   = group_by_year(data_by_male)
    female_data_by_year = group_by_year(data_by_female)
    output = {female: extract_data_point_for(year, female_data_by_year),
              male:   extract_data_point_for(year, male_data_by_year)}
  end

  def dropout_rate_by_race_in_year(year)
    return nil unless valid_year?(year)
    data_by_district = dropout_rates_data_for_district
    data_for_year    = group_by_year(data_by_district)[year.to_s]
    format_data_by_race(data_for_year, :category)
  end

  def dropout_rate_for_race_or_ethnicity(race)
    raise UnknownRaceError unless valid_race?(format_race(race))
    data_by_district = dropout_rates_data_for_district
    data_for_race    = pull_data_by_category(data_by_district, map_race.key(race))
    format_by_year(data_for_race)
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    return nil unless valid_year?(year)
    data_for_race = dropout_rate_for_race_or_ethnicity(race)
    data_for_race[year]
  end

  def graduation_rate_by_year
    data_by_district = grad_rates_data_for_district
    format_by_year(data_by_district)
  end

  def graduation_rate_in_year(year)
    return nil unless valid_year?(year)
    graduation_rate_by_year[year]
  end

  def kindergarten_participation_by_year
    data_by_district = kindergarten_participation_data_for_district
    format_by_year(data_by_district)
  end

  def kindergarten_participation_in_year(year)
    return nil unless valid_year?(year)
    kindergarten_participation_by_year[year]
  end

  def online_participation
    data_by_district = online_data_for_district
    format_by_year_with_ints(data_by_district)
  end

  def online_participation_in_year(year)
    return nil unless valid_year?(year)
    online_participation[year]
  end

  def participation_by_year
    data_by_district = enrollment_data_for_district
    format_by_year_with_ints(data_by_district)
  end

  def participation_in_year(year)
    return nil unless valid_year?(year)
    participation_by_year[year]
  end

  def participation_by_race_or_ethnicity(race)
    raise UnknownRaceError unless valid_race?(format_race(race))
    data_by_district = race_participation_data_for_district
    data_for_race    = pull_race_data(data_by_district, map_race.key(race))
    percents_only    = extract_data_format(data_for_race, "Percent")
    format_by_year(percents_only)
  end

  def participation_by_race_or_ethnicity_in_year(year)
    return nil unless valid_year?(year)
    data_by_district = race_participation_data_for_district
    percents_only    = extract_data_format(data_by_district, "Percent")
    data_for_year    = group_by_year(percents_only)[year.to_s]
    format_data_by_race(data_for_year, :race)
  end

  def special_education_by_year
    # This method returns a hash with years as keys and an floating point three-significant digits representing a percentage.
    #
    # enrollment.special_education_by_year

  end

  def special_education_in_year(year)
    return nil unless valid_year?(year)
    # This method takes one parameter:
    #
    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.
    #
    # The method returns a single three-digit floating point percentage.
    # enrollment.special_education_in_year(2013) # => 0.105
  end

  def remediation

  end

  def remediation_in_year(year)
    return nil unless valid_year?(year)

  end

  def dropout_rates_data_for_district
    pull_district_data(data[:enrollment][:dropout_rates])
  end

  def grad_rates_data_for_district
    pull_district_data(data[:enrollment][:hs_grad_rates])
  end

  def kindergarten_participation_data_for_district
    pull_district_data(data[:enrollment][:fullday_kindergartners])
  end

  def online_data_for_district
    pull_district_data(data[:enrollment][:online])
  end

  def enrollment_data_for_district
    pull_district_data(data[:enrollment][:regular_enrollment])
  end

  def race_participation_data_for_district
    pull_district_data(data[:enrollment][:by_race_ethnicity])
  end

  def format_data_by_race(data, variable)
    output = {}
    data.each do |data_point|
      race = map_race[data_point[variable]]
      next unless race
      output[race] = format_number(data_point[:data])
    end
    output
  end

  def format_by_year(data)
    output = {}
    data.each do |data_point|
      year = data_point[:timeframe].to_i
      output[year] = format_number(data_point[:data])
    end
    output
  end

  def format_by_year_with_ints(data)
    output = {}
    data.each do |data_point|
      year = data_point[:timeframe].to_i
      output[year] = data_point[:data].to_i
    end
    output
  end

  def pull_data_by_category(data_segment, category)
    data_segment.select { |data| data[:category] == category }
  end

  def pull_race_data(data_segment, race)
    data_segment.keep_if { |data| data[:race] == race }
  end

  def extract_data_point_for(key, data)
    format_number(data[key.to_s][0][:data])
  end

  def extract_data_format(data_segment, format)
    data_segment.keep_if { |data| data[:dataformat] == format }
  end

  def map_race
    {"Asian Students" => :asian,
     "Black Students" => :black,
     "Hispanic Students" => :hispanic,
     "Native American Students" => :native_american,
     "Native Hawaiian or Other Pacific Islander" => :pacific_islander,
     "Two or More Races" => :two_or_more,
     "White Students" => :white
    }
  end
end

# enrollment = Enrollment.new("ACADEMY 20", DataParser.new)  # => #<Enrollment:0x007fbe390414c0 @district_name="ACADEMY 20", @parser=#<DataParser:0x007fbe39041560 @data_dir="../data", @valid_years=["2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2011", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "2012", "...
# enrollment.dropout_rate_for_race_or_ethnicity(:asian)      # => {2011=>0.0, 2012=>0.007}
