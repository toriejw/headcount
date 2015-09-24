require_relative 'errors'
require_relative 'checking_valid_data'
require_relative 'formatting_data'
require 'pry'

class StatewideTesting
  include CheckingValidData
  include FormattingData
  attr_reader :district_name, :data

  def initialize(district_name, parser)
    @district_name = district_name
    @parser        = parser
    @data          = parser.load_statewide_testing_data # sort data by district here
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
    race = "Hawaiian/Pacific Islander" if race == "Pacific Islander"
    math_data    = format_data_by_race(race, data[:statewide_testing][:math])
    reading_data = format_data_by_race(race, data[:statewide_testing][:reading])
    writing_data = format_data_by_race(race, data[:statewide_testing][:writing])
    output = format_by_subject(math_data, reading_data, writing_data)
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    raise UnknownDataError unless valid_inputs_for_grade?(subject, grade, year)
    proficiency_by_grade = proficient_by_grade(grade)
    if proficiency_by_grade.keys.include?(year)
      proficiency_by_grade[year.to_i][subject.downcase]
    else
      raise UnknownDataError
    end
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    raise UnknownDataError unless (valid_subject?(subject) && valid_year?(year))
    proficiency_by_race = proficient_by_race_or_ethnicity(race)
    if proficiency_by_race.keys.include?(year)
      proficiency_by_race[year.to_i][subject.downcase]
    else
      raise UnknownDataError
    end
  end

  def proficient_for_subject_in_year(subject, year)
    raise UnknownDataError unless valid_subject?(subject)
    raise UnknownDataError unless (valid_year?(year) && year > 2010) # shouldn't be hard coded...

    race    = "All Students"
    data_for_subject    = format_data_by_race(race, data[:statewide_testing][subject])
    extract_data_point_for(year, data_for_subject)
  end

  def format_by_subject(math, reading, writing)
    output = {}
    math.each do |year, value| # way to not repeat this 3x?
      output[year.to_i] = {math: format_number(value[0][:data])}
    end
    reading.each do |year, value|
      reading_data = {reading: format_number(value[0][:data])}
      output[year.to_i] = output[year.to_i].merge(reading_data)
    end
    writing.each do |year, value|
      writing_data = {writing: format_number(value[0][:data])}
      output[year.to_i] = output[year.to_i].merge(writing_data)
    end
    output
  end

  def format_data_by_race(race, data_segment)
    data_by_district          = pull_district_data(data_segment)
    data_by_district_and_race = pull_race_data(race, data_by_district)
    group_by_year(data_by_district_and_race)
  end

  def pull_race_data(race, data_segment)
    # binding.pry
    data_segment.select { |data| data[:race_ethnicity] == race }
  end

  def pull_district_data_by_grade(grade)
    case grade
    when 3
      pull_district_data(data[:statewide_testing][:third_grade])
    when 8
      pull_district_data(data[:statewide_testing][:eighth_grade])
    end
  end

  def format_data(data_by_year, var_of_interest)
    output = {}
    data_by_year.each do |year, values|
      scores = []
      values.each { |hash| scores << {hash[var_of_interest].downcase.to_sym => format_number(hash[:data])} }
      output[year.to_i] = scores[0].merge(scores[1]).merge(scores[2])
    end
    output.each { |year, values| flatten(values) }
    output.delete_if { |year, values| values == {} }
  end
end
