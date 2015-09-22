require_relative 'data_parser'
require_relative 'district'

class DistrictRepository
  def self.from_csv(data_dir)
    # file   = File.expand_path("Pupil enrollment.csv", data_dir)
    parser = DataParser.new(data_dir)
    DistrictRepository.new(parser)
  end

  # def self.load(input_file)
  #   self.districts = parser.load_districts(input_file)
  #   load_data
  # end
  #
  # def load_data
  #   @data = parser.load_data
  # end
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
      matches << name if name =~ /(#{word_fragment})/i
    end
    matches
  end
end

# dr = DistrictRepository.new
# dr.load('/Users/Torie/Documents/turing/module_1/projects/headcount/test/fixtures/Pupil enrollment.csv')
# district = dr.find_all_matching("a")
# district
