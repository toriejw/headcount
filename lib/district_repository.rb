require_relative './data_parser'

class DistrictRepository

  def initialize
    @districts = []
  end

  def load(input_file)
    data_parser.load_districts(input_file)
  end

  def find_by_name

  end

  def find_all_matching

  end
end
