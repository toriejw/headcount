class Files # CHANGE TO CAMEL CASE - different systems handle spaces differently
  def self.statewide_testing_files
    {third_grade:  "3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
     eighth_grade: "8th grade students scoring proficient or above on the CSAP_TCAP.csv",
     math:         "Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
     reading:      "Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
     writing:      "Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}
  end

  def self.enrollment_files
     {dropout_rates:          "Dropout rates by race and ethnicity.csv",
      hs_grad_rates:          "High school graduation rates.csv",
      fullday_kindergartners: "Kindergartners in full-day program.csv",
      online:                 "Online pupil enrollment.csv",
      by_race_ethnicity:      "Pupil enrollment by race_ethnicity.csv",
      regular_enrollment:     "Pupil enrollment.csv",
      special_ed:             "Special education.csv"}
  end

  def self.economic_profile_files
     {income:       "Median household income.csv",
      poverty:      "School-aged children in poverty.csv",
      free_lunches: "Students qualifying for free or reduced price lunch.csv",
      title_one:    "Title I students.csv"}
  end
end
