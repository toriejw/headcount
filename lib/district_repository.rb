require_relative './data_parser'
require_relative './district'

class DistrictRepository
  attr_accessor :districts

  def initialize
    @districts = []
  end

  def load(input_file)
    self.districts = DataParser.load_districts(input_file)
  end

  def find_by_name(target_district)
    District.new(target_district) if districts.include?(target_district.upcase)
  end

  def find_all_matching(target_string)
    matches = []
    districts.each do |district|
      matches << district if district =~ /(#{target_string})/i
    end
    matches
  end
end

dr = DistrictRepository.new
dr.load('/Users/Torie/Documents/turing/module_1/projects/headcount/test/fixtures/Pupil enrollment.csv')
district = dr.find_all_matching("a")
district
