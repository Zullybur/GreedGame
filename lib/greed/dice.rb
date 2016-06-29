module Greed
  class Dice
    attr_reader :values

    # Roll -num- six sided dice and place results in an array
    def roll(num)
      @values = Array.new(num) { rand(1..6) }
    end
  end
end
