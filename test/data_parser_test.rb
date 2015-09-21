require_relative '../lib/data_parser'
# require_relative '../lib/files'

class DataParserTest < Minitest::Test
  attr_reader :file_path, :data, :statewide_testing_files, :economic_testing_files, :enrollment_testing_files
  def setup
    @file_path = File.expand_path('fixtures/Pupil enrollment.csv', __dir__)
    @data = DataParser.load_data
    @statewide_testing_files = {third_grade:  "3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                                # eighth_grade: "8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                                # math:         "Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                                reading:      "Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                                writing:      "Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                               }
    @economic_testing_files =  {income:       "Median household income.csv",
                                poverty:      "School-aged children in poverty.csv",
                                # free_lunches: "Students qualifying for free or reduced price lunch.csv",
                                # title_one:    "Title I students.csv"
                               }
    @enrollment_testing_files = {dropout_rates:          "Dropout rates by race and ethnicity.csv",
                                #  hs_grad_rates:          "High school graduation rates.csv",
                                #  fullday_kindergartners: "Kindergartners in full-day program.csv",
                                #  online:                 "Online pupil enrollment.csv",
                                #  by_race_ethnicity:      "Pupil enrollment by race_ethnicity.csv",
                                #  regular_enrollment:     "Pupil enrollment.csv",
                                 special_ed:             "Special education.csv"}
  end

  def test_loads_district_names_from_file
    districts = DataParser.load_districts(file_path)
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], districts
  end

  def test_Colorado_not_included_when_districts_loaded
    districts = DataParser.load_districts(file_path)
    refute districts.include?("Colorado" || "colorado")
  end

  def test_can_load_districts_when_variable_order_changes
    new_file = File.expand_path('fixtures/Pupil enrollment modified.csv', __dir__)
    districts = DataParser.load_districts(new_file)
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], districts
  end

  def test_district_names_are_upcased_when_loaded
    new_file = File.expand_path('fixtures/Pupil enrollment modified.csv', __dir__)
    districts = DataParser.load_districts(new_file)
    assert_equal ["ACADEMY 20", "ADAMS COUNTY 14"], districts
  end

  def test_parses_data
    data = DataParser.parse_data_from(statewide_testing_files) # NOT USING FIXTURES HERE
    expected_data = {:location=>"ACADEMY 20", :race_ethnicity=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.83"}
    assert data[:reading].any? { |data| data == expected_data }
  end

  def test_collects_valid_years # should probs go somewhere else
    # data = DataParser.parse_data_from({file: 'Pupil enrollment.csv'})
    valid_years = ["1995", "1997", "1999", "2000", "2001", "2002", "2003",
                   "2004", "2005", "2006", "2007", "2008", "2009", "2010",
                   "2011", "2012", "2013", "2014"]
    assert_equal valid_years, @data[:valid_years]
  end

  def test_can_load_only_statewide_testing_files
    expected_data = {:location=>"ACADEMY 20", :race_ethnicity=>"Asian", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.8268"}
    sw_data = DataParser.load_statewide_testing_data(statewide_testing_files)
    assert sw_data[:statewide_testing][:writing].any? { |data| data == expected_data }
  end

  def test_can_load_only_economic_profile_files
    expected_data = {:location=>"ACADEMY 20", :timeframe=>"2005-2009", :dataformat=>"Currency", :data=>"85060"}
    economic_data = DataParser.load_economic_profile_data(economic_testing_files)
    assert economic_data[:economic_profile][:income].any? { |data| data == expected_data }
  end

  def test_can_load_only_enrollment_files
    expected_data = {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Number", :data=>"1873"}
    enrollment_data = DataParser.load_enrollment_data(enrollment_testing_files)
    assert enrollment_data[:enrollment][:special_ed].any? { |data| data == expected_data }
  end

  def test_loads_all_data_at_once
    # data = DataParser.load_data
    expected_data = {:location=>"ACADEMY 20", :race_ethnicity=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.83"}
    assert data[:statewide_testing][:reading].any? { |data| data == expected_data }

    expected_data = {:location=>"ACADEMY 20", :timeframe=>"2013", :dataformat=>"Number", :data=>"341"}
    assert data[:enrollment][:online].any? { |data| data == expected_data }

    expected_data = {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Percent", :data=>"0.01072"}
    assert data[:economic_profile][:title_one].any? { |data| data == expected_data }
  end
end
