module FormattingData
  def pull_district_data(data_segment)
    data_segment.keep_if { |data| data[:location] == district_name }
  end

  def group_by_year(data_segment)
    data_segment.group_by { |data| data[:timeframe] }
  end

  def format_number(num)
    if num.length > 5
      num = num[0..4]
    end
    num.to_f
  end

  def format_race(race)
    race = race.to_s.capitalize
    case race
    when "Pacific_islander"
      race = "Hawaiian/Pacific Islander"
    when "Native_american"
      race = "Native American"
    when "Two_or_more"
      race = "Two or more"
    end
    race
  end                                                                                                             # => :pull_data_for_all_students_by_year
end                                                                                                  # => :pull_data_for_all_students_by_year