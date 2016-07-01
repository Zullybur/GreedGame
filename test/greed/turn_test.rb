absolutePath = File.expand_path(File.dirname(__FILE__))
require (absolutePath + '/../../lib/greed/turn')
require 'test/unit'

module Greed
  class TestTurn < Test::Unit::TestCase
    turn = Turn.new
    turn.take_turn
  end
end
