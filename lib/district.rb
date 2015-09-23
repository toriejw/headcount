require_relative 'statewide_testing'
require_relative 'enrollment'
require_relative 'economic_profile'

class District
  attr_reader :name, :parser
  def initialize(name, parser)
    @name   = name.upcase
    @parser = parser
  end

  def statewide_testing
    StatewideTesting.new(@name, @parser)
  end

  def enrollment
    Enrollment.new(@name, @parser)
  end

  def economic_profile
    EconomicProfile.new(@name, @parser)
  end
end
