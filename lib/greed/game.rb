absolute_path = File.expand_path(File.dirname(__FILE__))
require absolute_path + '/turn'

module Greed
  class Game

    def initialize
      @turn = Turn.new
      @players = []
    end

    def new_game
      player_count = player_count?
      init_players(player_count)
      get_player_names
      play_game
    end
    
    # Complete a full game of Greed, entering a final round when any player reaches
    # a score of 3000 or more
    def play_game
      final_round = false
      while not final_round
        current_player = @players.pop
        puts "Current player: #{current_player.name}"
        score = @turn.take_turn

        # Add score to player total if the player is 'in the game'
        # (scored more than 300 in a single turn at least once)
        if current_player.score > 0 || score >= 300
          puts "Your final score for this round was #{score}"
          current_player.score += score
          puts "Your total score is now #{current_player.score}\n"
        else
          puts "You did not score high enough to enter the game.\n"
        end

        # Check if this player has reached 3000, which triggers a final round
        final_round = true if current_player.score >= 3000
        # Otherwise, place them at the end of the line
        @players.unshift(current_player) if not final_round
      end

      puts "#{current_player.name} has triggerd the FINAL ROUND!"
      final_scores = [current_player]
      
      # Allow each remaining player one final round
      @players.each do |player|
        player.score += @turn.take_turn
        final_scores << player
      end

      output_results(final_scores)
    end

    # Output final scores in sorted order
    def output_results(scores)
      scores.sort!
      (1..scores.size) do |place|
        case place
        when 1 then puts "1st Place: #{scores[place].name}!"
        when 2 then puts "2nd Place: #{scores[place].name}"
        when 3 then puts "3rd Place: #{scores[place].name}"
        else puts "#{place}th Place: #{scores[place].name}"
        end
      end
    end
    
    # Get the number of players in the game from the user
    def player_count?
      loop do
        puts "Please enter the number of players (up to 9)"
        count = gets.chomp.to_i
        break count if count > 0 && count <= 9
      end
    end

    # Get the name of each player
    def get_player_names
      players.each do |player|
        puts "Enter a name for Player #{player.number} (up to 20 chars)"
        player.name = gets(20).chomp
      end
    end

    # Initialize the collection of players
    def init_players(player_count)
      (1..player_count).each do |num|
        # Place the players in a FIFO queue
        @players.unshift(Player.new(num))
      end
    end
  end
end
