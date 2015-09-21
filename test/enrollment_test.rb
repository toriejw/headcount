require_relative '../lib/enrolment'

class EnrollmentTest < Minitest::test
  attr_reader :enrollment
  def setup
    @enrollment = Enrollment.new("ACADEMY 20", DataParser.new)
  end

end
