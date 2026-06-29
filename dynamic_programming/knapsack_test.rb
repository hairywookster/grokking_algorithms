# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'knapsack'

class KnapsackTest < Minitest::Test

  def test_empty_sack_if_no_items_given
    # skip
    nil_items = nil
    empty_items = {}
    items = [nil_items, empty_items]
    items.each do |available_items|
      result = DynamicProgrammingKnapsack.fill(available_items, 57)
      assert_empty result.items
      assert_equal 0, result.value_of_contents
      assert_equal 0, result.total_weight
      assert_equal '0/57 valued at: 0', result.to_s
    end
  end

  def test_knapsack_contents_when_items_available_but_capacity_is_zero
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    available_items = [guitar]
    result = DynamicProgrammingKnapsack.fill(available_items, 0)
    assert_empty result.items
  end

  def test_knapsack_contents_when_items_available_but_capacity_is_negative
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    available_items = [guitar]
    result = DynamicProgrammingKnapsack.fill(available_items, -55)
    assert_empty result.items
  end

  def test_knapsack_contents_when_one_item_that_fits_available
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    available_items = [guitar]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_equal [guitar], result.items
    assert_equal 1500, result.value_of_contents
    assert_equal 1, result.total_weight
    assert_equal '1/4 valued at: 1500', result.to_s
  end

  def test_knapsack_contents_when_one_item_that_doesnt_fit_available
    # skip
    guitar = KnapsackItem.new(:guitar, 5, 1500)
    available_items = [guitar]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_empty result.items
    assert_equal 0, result.value_of_contents
    assert_equal 0, result.total_weight
    assert_equal '0/4 valued at: 0', result.to_s
  end

  def test_knapsack_contents_when_items_available
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    stereo = KnapsackItem.new(:stereo, 4, 3000)
    laptop = KnapsackItem.new(:laptop, 3, 2000)

    available_items = [guitar, stereo, laptop]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_equal [guitar, laptop], result.items
    assert_equal 3500, result.value_of_contents
    assert_equal 4, result.total_weight
    assert_equal '4/4 valued at: 3500', result.to_s
  end

  def test_knapsack_contents_when_items_available_different_ordering_a
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    stereo = KnapsackItem.new(:stereo, 4, 3000)
    laptop = KnapsackItem.new(:laptop, 3, 2000)

    available_items = [guitar, laptop, stereo]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_equal [guitar, laptop], result.items
    assert_equal 3500, result.value_of_contents
    assert_equal 4, result.total_weight
    assert_equal '4/4 valued at: 3500', result.to_s
  end

  def test_knapsack_contents_when_items_available_different_ordering_b
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    stereo = KnapsackItem.new(:stereo, 4, 3000)
    laptop = KnapsackItem.new(:laptop, 3, 2000)

    available_items = [stereo, guitar, laptop]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_equal [guitar, laptop], result.items
    assert_equal 3500, result.value_of_contents
    assert_equal 4, result.total_weight
    assert_equal '4/4 valued at: 3500', result.to_s
  end

  def test_knapsack_contents_when_items_available_different_ordering_c
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    stereo = KnapsackItem.new(:stereo, 4, 3000)
    laptop = KnapsackItem.new(:laptop, 3, 2000)

    available_items = [stereo, laptop, guitar]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_equal [laptop, guitar], result.items
    assert_equal 3500, result.value_of_contents
    assert_equal 4, result.total_weight
    assert_equal '4/4 valued at: 3500', result.to_s
  end

  def test_knapsack_contents_when_items_available_different_ordering_d
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    stereo = KnapsackItem.new(:stereo, 4, 3000)
    laptop = KnapsackItem.new(:laptop, 3, 2000)

    available_items = [laptop, stereo, guitar]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_equal [laptop, guitar], result.items
    assert_equal 3500, result.value_of_contents
    assert_equal 4, result.total_weight
    assert_equal '4/4 valued at: 3500', result.to_s
  end

  def test_knapsack_contents_when_items_available_different_ordering_e
    # skip
    guitar = KnapsackItem.new(:guitar, 1, 1500)
    stereo = KnapsackItem.new(:stereo, 4, 3000)
    laptop = KnapsackItem.new(:laptop, 3, 2000)

    available_items = [laptop, guitar, stereo]

    result = DynamicProgrammingKnapsack.fill(available_items, 4)
    assert_equal [laptop, guitar], result.items
    assert_equal 3500, result.value_of_contents
    assert_equal 4, result.total_weight
    assert_equal '4/4 valued at: 3500', result.to_s
  end
end
