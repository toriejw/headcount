module FormattingData
  def pull_district_data(data_segment)
    self.district_name = "Colorado" if district_name == "COLORADO"
    data_segment.select { |data| data[:location] == district_name }
  end

  def group_by_year(data_segment)
    grouped_data = data_segment.group_by { |data| data[:timeframe] }
    flatten(grouped_data)
  end

  def format_by_year(data)
    output = {}
    data.each do |data_point|
      year = data_point[:timeframe].to_i
      output[year] = format_number(data_point[:data])
    end
    flatten(output)
  end

  def extract_data_format(data_segment, format)
    data_segment.keep_if { |data| data[:dataformat] == format }
  end

  def format_number(num)
    if not_data.include?(num)
      num = nil
    else
      num = num.to_s[0..4]
      num.to_f
    end
  end

  def flatten(data)
    data.delete_if { |key, value| value.nil? }
  end

  def not_data
    ["N/A", "LNE", "#VALUE!", nil]
  end

  def format_race(race)
    case race
    when :pacific_islander
      race = "Pacific Islander"
    when :native_american
      race = "Native American"
    when :two_or_more
      race = "Two or more"
    else
      race.to_s.capitalize
    end
  end

  def extract_data_point_for(key, data)
    format_number(data[key.to_s][0][:data])
  end
end

# include FormattingData
#
# format_race(:pacific_islander)
