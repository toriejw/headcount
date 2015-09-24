require_relative 'data_parser'
require_relative 'district'

class DistrictRepository
  def self.from_csv(data_dir)
    parser = DataParser.new(data_dir)
    DistrictRepository.new(parser)
  end

  attr_accessor :districts_by_name, :parser

  def initialize(parser)
    @parser            = parser
    @districts_by_name = parser.district_names
                               .map { |name| [name, District.new(name, parser)] }
                               .to_h
  end


  def load_statewide_testing_data
    parser.load_statewide_testing_data
  end

  def districts
    @districts_by_name.keys
  end

  def find_by_name(name)
    @districts_by_name[name.upcase]
  end

  def find_all_matching(word_fragment)
    matches = []
    @districts_by_name.each do |name, district|
      matches << district if name =~ /(#{word_fragment})/i # CHANGED NAME TO DISTRICT TO PASS TEST HARNESS
    end
    matches
  end
end
