# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'bakery_nearest_neighbour'

class BakeryNearestNeighbourTest < Minitest::Test

  def test_no_prediction_when_no_neighbours
    # skip
    nil_neighbours = nil
    empty_neighbours = []
    bakery_day = BakeryNearestNeighbour::BakeryDay.new(0, 1,1, 5)
    neighbours = [nil_neighbours, empty_neighbours]
    neighbours.each do |bakery_day_neighbour_list|
      result = BakeryNearestNeighbour.predict(bakery_day_neighbour_list, bakery_day)
      assert_nil result
    end
  end

  def test_no_prediction_when_no_bakery_day_to_predict
    # skip
    bakery_day_neighbour_list = [BakeryNearestNeighbour::BakeryDay.new(5, 1,1, 5)]
    bakery_day = nil
    result = BakeryNearestNeighbour.predict(bakery_day_neighbour_list, bakery_day)
    assert_nil result
  end

  def test_accurate_prediction
    # skip
    day1 = BakeryNearestNeighbour::BakeryDay.new(300, 0,1, 5)
    day2 = BakeryNearestNeighbour::BakeryDay.new(225, 1,1, 3)
    day3 = BakeryNearestNeighbour::BakeryDay.new(75, 0,1, 1)
    day4 = BakeryNearestNeighbour::BakeryDay.new(200, 1,0, 4)
    day5 = BakeryNearestNeighbour::BakeryDay.new(150, 0,0, 4)
    day6 = BakeryNearestNeighbour::BakeryDay.new(50, 0,0, 2)
    bakery_day_neighbour_list = [day1, day2, day3, day4, day5, day6]
    bakery_day = BakeryNearestNeighbour::BakeryDay.new(0, 0,1, 4)
    result = BakeryNearestNeighbour.predict(bakery_day_neighbour_list, bakery_day)
    assert_equal 219, result   #219 is day1 + day2 + day4 + day5 / 4 and rounded to nearest loaf
  end


end