absolute_path = File.expand_path(File.dirname(__FILE__))
require absolute_path + '/dice'
require absolute_path + '/score'
require 'pry'

module Greed
  class Turn

    def initialize
      @dice = Dice.new
      @score = Score.new
    end

    # Run a full single turn for a player until they choose to stop, or score 0
    def take_turn
      score = 0
      # Make the initial roll
      roll(5)
      result = @score.calc_score(@dice.values)
      puts "Your initial roll is: #{@dice.values}."

      # While score is not zero:
      while result['score'] != 0
        score += result['score']

        # Check if the player wants to roll again
        break unless reroll?(result['live_dice'], score)

        # Roll the dice
        roll(result['live_dice'])
        result = @score.calc_score(@dice.values)
        puts "You rolled: #{@dice.values} and scored: #{result['score']}."
      end

      # Return the total score, or zero if the player rolled a zero round
      return (result['score'] != 0 ? score : 0)
    end

    private
    # Allow player to select dice to re-roll
    def reroll?(num_dice, score)
      response = ""
      loop do
        puts "Current round score: #{score}"
        puts "You have #{num_dice} live dice, would you like to re-roll them?"
        puts "(Y)es or (N)o:"
        response = get_input
        break if response == "Y" || response == "N"
      end

      response == "Y"
    end

    def get_input
      STDIN.gets.chomp.upcase[0]
    end

    # Roll the given number of dice
    def roll(num)
      @dice.roll(num)
    end
  end
end
