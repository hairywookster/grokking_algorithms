# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'greedy_knapsack'

class GreedyKnapsackTest < Minitest::Test

  def test_empty_sack_if_no_items_given
    # skip
    nil_items = nil
    empty_items = {}
    items = [nil_items, empty_items]
    items.each do |available_items|
      result = GreedyKnapsack.fill(available_items, 57)
      assert_empty result
    end
  end

  def test_knapsack_contents_when_items_available_but_capacity_is_zero
    # skip
    available_items = []
    result = GreedyKnapsack.fill(available_items, 0)
    assert_equal [], result.items
  end

  def test_knapsack_contents_when_items_available_but_capacity_is_negative
    # skip
    available_items = []
    result = GreedyKnapsack.fill(available_items, -55)
    assert_equal [], result.items
  end

  def test_knapsack_contents_when_items_available
    # skip
    guitar = KnapsackItem.new(:guitar, 5, 500)
    lute = KnapsackItem.new(:lute, 1, 600)
    harmonica = KnapsackItem.new(:harmonica, 2, 1000)
    banjo = KnapsackItem.new(:banjo, 7, 600)
    lyar = KnapsackItem.new(:lyar, 3, 800)
    xylophone = KnapsackItem.new(:xylophone, 9, 2000)
    keyboard = KnapsackItem.new(:keyboard, 14, 900)

    # Randomly shuffle the items to confirm the order does not matter for the current list of items
    available_items = [guitar, lute, harmonica, banjo, lyar, xylophone, keyboard ].shuffle!

    result = GreedyKnapsack.fill(available_items, 16)
    assert_equal [xylophone, harmonica, lyar, lute], result.items
    refute result.full?
    assert_equal 4400, result.value_of_contents
    assert_equal '15/16 valued at: 4400', result.to_s
  end

end
