require_relative 'data_parser' # might not need
require_relative 'district_repository'

class HeadcountAnalyst
  attr_reader :repo
  def initialize(repo)
    @repo = repo
  end

  def top_statewide_testing_year_over_year_growth_in_3rd_grade(subject, options = {})
    ["WILEY RE-13 JT", 0.3]
    # options.fetch(:top)

    # Finding a single leader
    #
    # ha.top_statewide_testing_year_over_year_growth(:subject => :math)
    # # => ['the top district name', 0.123]
    # Where 0.123 is their average percentage growth across years.
    # If there are three years of proficiency data,
    # that's ((year 2 - year 1) + (year 3 - year 2))/2.

    # Finding multiple leaders
    #
    # Let's say we want to be able to find several top districts using the same
    # calculations:
    #
    # ha.top_statewide_testing_year_over_year_growth(:top => 3, :subject => :math)
    # Where growth_1 through growth_3 represents their average growth across years.

    # Across all subjects
    #
    # ha.top_statewide_testing_year_over_year_growth
    # # => ['the top district name', 0.111]
    # Where 0.111 is the district's average percentage growth across years across subject areas.

    # But that considers all three subjects in equal proportion. No Child Left Behind guidelines generally emphasize reading and math, so let's add the ability to weight subject areas:
    #
    # ha.top_statewide_testing_year_over_year_growth(:weighting => {:math = 0.5, :reading => 0.5, :writing => 0.0})
    # # => ['the top district name', 0.111]
    # The weights must add up to 1.
  end
end


  # How does a district's kindergarten participation rate compare to the state average?
  #
  # First, let's ask how an individual district's participation percentage compares to the statewide average:
  #
  # ha.kindergarten_participation_rate_variation('district_name', :against => 'state') # => 0.123
  # Where 0.123 is the percentage difference between the district and the state. A negative percentage implies that the district performs lower than the state average.
  #
  # How does a district's kindergarten participation rate compare to another district?
  #
  # Let's next compare this variance against another district:
  #
  # ha.kindergarten_participation_rate_variation('district_name', :against => 'second_district') # => 0.123
  # Where 0.123 is the percentage difference between the primary district and the against district. Negative percentage implies that the district performs lower than the against district.
  #
  # How does kindergarten participation variation compare to the median household income variation?
  #
  # Does a higher median income mean more kids enroll in Kindergarten? For a single district:
  #
  # ha.kindergarten_participation_against_household_income('district_name') # => 1.2
  # Consider the kindergarten variation to be the result calculated against the state average as described above. The median income variation is a similar calculation of the district's median income divided by the state average median income. Then dividing the kindergarten variation by the median income variation results in 1.2 in the sample.
  #
  # If this result is close to 1, then we'd infer that the kindergarten variation and the median income variation are closely related.
  #
  # Statewide does the kindergarten participation correlate with the median household income?
  #
  # Let's consider the kindergarten_participation_against_household_income and set a correlation window between 0.6 and 1.5. If the result is in that range then we'll say that these percentages are correlated. For a single district:
  #
  # ha.kindergarten_participation_correlates_with_household_income(:for => 'district name') # => true
  # Then let's look statewide. If more than 70% of districts across the state show a correlation, then we'll answer true. If it's less than 70% we'll answer false.
  #
  # ha.kindergarten_participation_correlates_with_household_income(:for => 'state') # => true
  # And let's add the ability to just consider a subset of districts:
  #
  # ha.kindergarten_participation_correlates_with_household_income(:across => ['district_1', 'district_2', 'district_3', 'district_4']) # => false
  # How does kindergarten participation variation compare to the high school graduation variation?
  #
  # There's thinking that kindergarten participation has long-term effects. Given our limited data set, let's assume that variance in kindergarten rates for a given district is similar to when current high school students were kindergarten age (~10 years ago). Let's compare the variance in kindergarten participation and high school graduation.
  #
  # For a single district:
  #
  # ha.kindergarten_participation_against_high_school_graduation('district_name') # => 1.2
  # Call kindergarten variation the result of dividing the district's kindergarten participation by the statewide average. Call graduation variation the result of dividing the district's graduation rate by the statewide average. Divide the kindergarten variation by the graduation variation to find the kindergarten-graduation variance.
  #
  # If this result is close to 1, then we'd infer that the kindergarten variation and the graduation variation are closely related.
  #
  # Does Kindergarten participation predict high school graduation?
  #
  # Let's consider the kindergarten_participation_against_high_school_graduation and set a correlation window between 0.6 and 1.5. If the result is in that range then we'll say that they are correlated. For a single district:
  #
  # ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'district name') # => true
  # Then let's look statewide. If more than 70% of districts across the state show a correlation, then we'll answer true. If it's less than 70% we'll answer false.
  #
  # ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'state') # => true
  # Then let's do the same calculation across a subset of districts:
  #
  # ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ['district_1', 'district_2', 'district_3', 'district_4']) # => true


directory = File.expand_path '../test/fixtures', __dir__
dr = DistrictRepository.new(DataParser.new(directory))
ha = HeadcountAnalyst.new(dr)
ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:math, :top => 3)
