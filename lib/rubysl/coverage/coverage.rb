require "rubinius/coverage"

module Coverage
  @coverage_generator = nil

  def self.start
    @coverage_generator = Rubinius::Coverage.new
    @coverage_generator.start
  end

  def self.result
    if @coverage_generator
      @coverage_generator.result
    else
      {}
    end
  end

  class << self
    alias_method :peek_result, :result
  end
end
