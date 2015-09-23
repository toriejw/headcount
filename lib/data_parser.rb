require 'csv'
require_relative 'files'

class DataParser
  attr_reader :data_dir
  attr_accessor :valid_years
  def initialize(data_dir = '../data')
    @data_dir    ||= data_dir
    @valid_years ||= []
  end

  def district_names
    @district_names ||= load_districts(
      File.join(data_dir, Files.statewide_testing_files[:third_grade])
    )
  end

  def load_districts(input_file)
    district_index = find_index(input_file, "Location")
    districts = group_districts(input_file, district_index)
  end

  def find_index(file, string)
    handle = File.open(file)
    line = handle.readline.split(",").each { |elem| elem.downcase!.strip! } # chaining two ! methods okay?
    handle.close
    line.index(string.downcase)
  end

  def group_districts(file, district_index)
    districts = []
    CSV.foreach(file) do |line|
      next if non_districts.include?(line[district_index].upcase)
      districts << line[district_index].upcase
    end
    districts.uniq
  end

  def non_districts
    ["LOCATION"]
  end

  def load_data(statewide_files = Files.statewide_testing_files, enrollment_files = Files.enrollment_files, economic_files = Files.economic_profile_files)
    @valid_years = []
    @statewide_testing_data ||= parse_data_from(statewide_files)
    @enrollment_data        ||= parse_data_from(enrollment_files)
    @economic_data          ||= parse_data_from(economic_files)

    { statewide_testing: @statewide_testing_data,
      enrollment:        @enrollment_data,
      economic_profile:  @economic_data,
      valid_years:       clean_valid_years
    }
  end

  def load_statewide_testing_data(files = Files.statewide_testing_files)
    @statewide_testing_data ||= parse_data_from(files)
    {statewide_testing: @statewide_testing_data,
     valid_years:       clean_valid_years
    }
  end

  def load_enrollment_data(files = Files.enrollment_files)
    @enrollment_data ||= parse_data_from(files)
    {enrollment:  @enrollment_data,
     valid_years: clean_valid_years
    }
  end

  def load_economic_profile_data(files = Files.economic_profile_files)
    @economic_data ||= parse_data_from(files)
    {economic_profile:  @economic_data,
     valid_years:       clean_valid_years
    }
  end

  def clean_valid_years
    @valid_years.uniq.sort.delete_if { |year| year[4] == "-"}
  end

  def parse_data_from(files)
    data = {}
    files.each do |key, file|
      file = File.join(data_dir, file)
      file_path = File.expand_path(file, __dir__)
      data[key] = CSV.read(file_path, :headers => true, :header_converters => :symbol)
                     .map(&:to_h)
      data[key].each { |data| @valid_years << data[:timeframe] }
    end
    data
  end
end

# DataParser.load_districts('/Users/Torie/Documents/turing/module_1/projects/headcount/data/Pupil enrollment.csv')
# data = DataParser.new.load_enrollment_data
# data[:enrollment][:by_race_ethnicity].size # => 22378
