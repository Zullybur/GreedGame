absolutePath = File.expand_path(File.dirname(__FILE__))
require (absolutePath + '/../../lib/greed/score')
require 'test/unit'
require 'pry'

module Greed
  # Tests from Ruby Koans "about_scoring_project"
  class TestScore < Test::Unit::TestCase
    $score = Score.new

    def test_argument_error_when_nil_passed
      assert_raise(ArgumentError) do
        $score.calc_score(nil)
      end
    end

    def test_score_of_an_empty_list_is_zero
      assert_equal 0, $score.calc_score([])['score']
      assert_equal 5, $score.calc_score([])['live_dice']
    end

    def test_score_of_a_single_roll_of_5_is_50
      assert_equal 50, $score.calc_score([5])['score']
      assert_equal 5, $score.calc_score([5])['live_dice']
    end

    def test_score_of_a_single_roll_of_1_is_100
      assert_equal 100, $score.calc_score([1])['score']
      assert_equal 5, $score.calc_score([1])['live_dice']
    end

    def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
      assert_equal 300, $score.calc_score([1,5,5,1])['score']
      assert_equal 5, $score.calc_score([1,5,5,1])['live_dice']
    end

    def test_score_of_single_2s_3s_4s_and_6s_are_zero
      assert_equal 0, $score.calc_score([2,3,4,6])['score']
      assert_equal 4, $score.calc_score([2,3,4,6])['live_dice']
    end

    def test_score_of_a_triple_1_is_1000
      assert_equal 1000, $score.calc_score([1,1,1])['score']
      assert_equal 5, $score.calc_score([1,1,1])['live_dice']
    end

    def test_score_of_other_triples_is_100x
      assert_equal 200, $score.calc_score([2,2,2])['score']
      assert_equal 5, $score.calc_score([2,2,2])['live_dice']
      assert_equal 300, $score.calc_score([3,3,3])['score']
      assert_equal 5, $score.calc_score([3,3,3])['live_dice']
      assert_equal 400, $score.calc_score([4,4,4])['score']
      assert_equal 5, $score.calc_score([4,4,4])['live_dice']
      assert_equal 500, $score.calc_score([5,5,5])['score']
      assert_equal 5, $score.calc_score([5,5,5])['live_dice']
      assert_equal 600, $score.calc_score([6,6,6])['score']
      assert_equal 5, $score.calc_score([6,6,6])['live_dice']
    end

    def test_score_of_mixed_is_sum
      assert_equal 250, $score.calc_score([2,5,2,2,3])['score']
      assert_equal 1, $score.calc_score([2,5,2,2,3])['live_dice']
      assert_equal 550, $score.calc_score([5,5,5,5])['score']
      assert_equal 5, $score.calc_score([5,5,5,5])['live_dice']
      assert_equal 1100, $score.calc_score([1,1,1,1])['score']
      assert_equal 5, $score.calc_score([1,1,1,1])['live_dice']
      assert_equal 1200, $score.calc_score([1,1,1,1,1])['score']
      assert_equal 5, $score.calc_score([1,1,1,1,1])['live_dice']
      assert_equal 1150, $score.calc_score([1,1,1,5,1])['score']
      assert_equal 5, $score.calc_score([1,1,1,5,1])['live_dice']
    end
  end
end
