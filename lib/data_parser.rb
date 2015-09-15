class DataParser

  def self.load_districts(input_file)
    handle = File.open(input_file)
    district_index = find_index(handle, "Location")
    districts = group_districts(handle, district_index)
  end

  def self.find_index(handle, string)
    line = handle.readline.split(",").each { |elem| elem.downcase!.strip! } # chaining two ! methods okay?
    line.index(string.downcase)
  end

  def self.group_districts(handle, district_index)
    districts = []
    until handle.eof?
      line = handle.readline.split(",")
      districts << line[district_index].chomp.upcase
    end
    districts.delete("COLORADO")
    districts.uniq
  end
end

# DataParser.load_districts('/Users/Torie/Documents/turing/module_1/projects/headcount/data/Pupil enrollment.csv')
