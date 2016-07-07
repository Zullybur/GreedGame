module Greed
  class Player
    include Comparable

    attr_accessor(:name, :score)
    attr_reader :number

    def initialize(num)
      @number = num
      @score = 0
    end

    def <=>(other)
      @score <=> other.score
    end

    def inspect
      return "P#{@number}: #{@name} (#{@score})"
    end
  end
end
