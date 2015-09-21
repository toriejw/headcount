require_relative './district_repository'
require 'pry'

class UnknownDataError < StandardError
end

class StatewideTesting # TODO keep_if is destructive...want to keep original data
  attr_reader :district_name, :data
  attr_accessor :dr
  def initialize(district_name)
    @district_name = district_name
    @dr = DistrictRepository.new
    @data = @dr.load_statewide_testing_data
  end

  def proficient_by_grade(grade)
    raise UnknownDataError unless valid_grade?(grade)
    district_data = pull_district_data_by_grade(grade)
    data_by_year = group_by_year(district_data)
    format_data(data_by_year, :score)
  end

  def proficient_by_race_or_ethnicity(race)
    race = format_race(race)
    raise UnknownDataError unless valid_race?(race)
    math_data    = format_data_by_race(race, data[:statewide_testing][:math])
    reading_data = format_data_by_race(race, data[:statewide_testing][:reading])
    writing_data = format_data_by_race(race, data[:statewide_testing][:writing])
    output = format_by_subject(math_data, reading_data, writing_data)
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    raise UnknownDataError unless valid_inputs_for_grade?(subject, grade, year)
    proficiency_by_grade = proficient_by_grade(grade)
    proficiency_by_grade[year.to_i][subject.downcase]
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    raise UnknownDataError unless (valid_subject?(subject) && valid_year?(year))
    proficiency_by_race = proficient_by_race_or_ethnicity(race)
    proficiency_by_race[year.to_i][subject.downcase]
  end

  def proficient_for_subject_in_year(subject, year)
    raise UnknownDataError unless (valid_subject?(subject) && valid_year?(year))

    # Example:
    # statewide_testing.proficient_for_subject_in_year(:math, 2012) # => 0.680
  end

  def valid_subject?(subject)
    [:math, :reading, :writing].include?(subject.downcase)
  end

  def valid_grade?(grade)
    [3, 8].include?(grade)
  end

  def valid_race?(race)
    ["Asian", "Black", "Pacific Islander", "Hispanic",
     "Native American", "Two or more", "White"].include?(race)
  end

  def valid_year?(year)
    data[:valid_years].include?(year.to_s)
  end

  def valid_inputs_for_grade?(subject, grade, year)
    (valid_subject?(subject) && valid_grade?(grade) && valid_year?(year))
  end

  def valid_inputs_for_race?(subject, race, year)
    (valid_subject?(subject) && valid_race?(race) && valid_year?(year))
  end

  def format_by_subject(math, reading, writing)
    output = {}
    math.each do |year, value| # way to not repeat this 3x?
      output[year.to_i] = {math: format_number(value[0][:data])}
    end
    reading.each do |year, value|
      output[year.to_i] = output[year.to_i].merge({reading: format_number(value[0][:data])})
    end
    writing.each do |year, value|
      output[year.to_i] = output[year.to_i].merge({writing: format_number(value[0][:data])})
    end
    output
  end

  def format_data_by_race(race, data_segment)
    data_by_district = pull_district_data(data_segment)
    data_by_district_and_race = pull_race_data(race, data_segment)
    group_by_year(data_by_district_and_race)
  end

  def format_race(race)
    race = race.to_s.capitalize
    case race
    when "Pacific_islander"
      race = "Hawaiian/Pacific Islander"
    when "Native_american"
      race = "Native American"
    when "Two_or_more"
      race = "Two or more"
    end
    race
  end

  def pull_race_data(race, data_segment)
    data_segment.keep_if { |data| data[:race_ethnicity] == race }
  end

  def pull_district_data(data_segment)
    data_segment.keep_if { |data| data[:location] == district_name }
  end

  def pull_district_data_by_grade(grade)
    case grade
    when 3
      pull_district_data(data[:statewide_testing][:third_grade])
    when 8
      pull_district_data(data[:statewide_testing][:eighth_grade])
    end
  end

  def group_by_year(district_data)
    district_data.group_by { |data| data[:timeframe] }
  end

  def format_number(num)
    if num.length > 5
      num = num[0..4]
    end
    num.to_f
  end

  def format_data(data_by_year, var_of_interest)
    output = {}
    data_by_year.each do |year, values|
      scores = []
      values.each { |hash| scores << {hash[var_of_interest].downcase.to_sym => format_number(hash[:data])} }
      output[year.to_i] = scores[0].merge(scores[1]).merge(scores[2])
    end
    output
  end
end
