require_relative './statewide_testing'
require_relative './enrollment'

class District
  attr_reader :name
  def initialize(name)
    @name = name.upcase
  end

  def statewide_testing
    StatewideTesting.new(@name)
  end

  def enrollment
    Enrollment.new(@name)
  end
end
