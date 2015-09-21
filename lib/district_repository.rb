require_relative './data_parser'
require_relative './district'

class DistrictRepository
  attr_accessor :districts, :data

  def initialize
    @districts = []
    @data = nil
  end

  def load(input_file)
    self.districts = DataParser.load_districts(input_file)
    load_data
  end

  def load_data
    @data = DataParser.load_data
  end

  def load_statewide_testing_data
    DataParser.load_statewide_testing_data
  end

  def find_by_name(name)
    District.new(name) if districts.include?(name.upcase)
  end

  def find_all_matching(word_fragment)
    matches = []
    districts.each do |district|
      matches << district if district =~ /(#{word_fragment})/i
    end
    matches
  end
end

# dr = DistrictRepository.new
# dr.load('/Users/Torie/Documents/turing/module_1/projects/headcount/test/fixtures/Pupil enrollment.csv')
# district = dr.find_all_matching("a")
# district
