require 'csv'
require_relative './files'

class DataParser
  attr_accessor :valid_years
  def initialize
    @valid_years = []
  end

  def self.load_districts(input_file)
    district_index = find_index(input_file, "Location")
    districts = group_districts(input_file, district_index)
  end

  def self.find_index(file, string)
    handle = File.open(file)
    line = handle.readline.split(",").each { |elem| elem.downcase!.strip! } # chaining two ! methods okay?
    handle.close # need to do this?
    line.index(string.downcase)
  end

  def self.group_districts(file, district_index)
    districts = []
    CSV.foreach(file) do |line|
      next if non_districts.include?(line[district_index].upcase)
      districts << line[district_index].upcase
    end
    districts.uniq
  end

  def self.non_districts
    ["COLORADO", "LOCATION"]
  end

  def self.load_data(statewide_files = Files.statewide_testing_files, enrollment_files = Files.enrollment_files, economic_files = Files.economic_profile_files)
    @valid_years = []
    statewide_testing_data = parse_data_from(statewide_files)
    enrollment_data        = parse_data_from(enrollment_files)
    economic_data  = parse_data_from(economic_files)

    data = {statewide_testing: statewide_testing_data,
            enrollment:        enrollment_data,
            economic_profile:  economic_data,
            valid_years:       clean_valid_years
           }
  end

  def self.load_statewide_testing_data(files = Files.statewide_testing_files)
    statewide_testing_data = parse_data_from(files)
    data = {statewide_testing: statewide_testing_data,
            valid_years:       clean_valid_years
           }
  end

  def self.load_enrollment_data(files = Files.enrollment_files)
    enrollment_data = parse_data_from(files)
    data = {enrollment:  enrollment_data,
            valid_years: clean_valid_years
           }
  end

  def self.load_economic_profile_data(files = Files.economic_profile_files)
    economic_data = parse_data_from(files)
    data = {economic_profile:  economic_data,
            valid_years:       clean_valid_years
           }
  end

  def self.clean_valid_years
    @valid_years.uniq.sort.delete_if { |year| year[4] == "-"}
  end

  def self.parse_data_from(files)
    data = {}
    files.each do |key, file|
      file = "../data/#{file}"
      file_path = File.expand_path(file, __dir__)
      data[key] = CSV.read(file_path, headers: true, header_converters: :symbol)
                     .map(&:to_h)
      data[key].each { |data| @valid_years << data[:timeframe] }
    end
    data
  end
end

# DataParser.load_districts('/Users/Torie/Documents/turing/module_1/projects/headcount/data/Pupil enrollment.csv')
# data = DataParser.load_statewide_testing_data
# puts data[:statewide_testing].keys
