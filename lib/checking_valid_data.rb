module CheckingValidData
  def valid_subject?(subject)
    [:math, :reading, :writing].include?(subject.downcase)
  end

  def valid_grades
    [3, 8]
  end

  def valid_grade?(grade)
    valid_grades.include?(grade)
  end

  def valid_race?(race)
    ["Asian", "Black", "Pacific Islander", "Hispanic",
     "Native American", "Two or more", "White"].include?(race)
  end

  def valid_year?(year)
    data[:valid_years].include?(year.to_s)
  end

  def valid_inputs_for_grade?(subject, grade, year)
    (valid_subject?(subject) && valid_grade?(grade) && valid_year?(year))
  end

  def valid_inputs_for_race?(subject, race, year)
    (valid_subject?(subject) && valid_race?(race) && valid_year?(year))
  end

end
