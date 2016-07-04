absolute_path = File.expand_path(File.dirname(__FILE__))
require absolute_path + '/greed/game'

include Greed

greed_game = Game.new

done = false

greed_game.new_game

puts "Thanks for playing!"
