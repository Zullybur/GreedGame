module Greed 
  def calc_score(dice)
    # Catch nil parameter
    raise ArgumentError, "Dice must be provided" unless dice
    count_hash = count_dice_results(dice)
    calculate_score(count_hash)
  end

  # Create a hash where key = die face and value = number of occurences
  private
  def count_dice_results(dice)
    hash = Hash.new(0)
    dice.each do |num|
      hash[num] += 1
    end
    hash
  end

  # Calculate score based on GREED_RULES.txt
  def calculate_score(hash)
    hash.inject(0) do |score, (die, count)|

      # Remaining is number of dice not part of a triple
      remaining = count % 3

      # 100 points for any individual 1's (not in a set of three)
      # 50 points for any indivudal 5's (not in a set of three)
      individual_score = case die
                         when 1 then remaining * 100
                         when 5 then remaining * 50
                         else 0
                         end

      # Three 1's is worth 1000, not 100
      die = 10 if die == 1
      
      # (100 * face value) points for any set of three
      triple_score = (count / 3) * (100 * die)

      # Score is points-from-triples + points-from-individuals
      score + triple_score + individual_score
    end
end
