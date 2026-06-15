# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'binary_search'

class BinarySearchTest < Minitest::Test


  def test_finds_no_value_in_a_nil_array
    # skip
    nil_array = nil
    binary_search = BinarySearch.new(nil_array)
    assert_nil binary_search.locate_item(555)
    refute binary_search.exist?(555)
  end

  def test_finds_no_value_in_an_empty_array
    # skip
    empty_array = []
    binary_search = BinarySearch.new(empty_array)
    assert_nil binary_search.locate_item(555)
    refute binary_search.exist?(555)
  end

  def test_finds_no_value_in_a_single_value_array
    # skip
    sorted_array = [1]
    binary_search = BinarySearch.new(sorted_array)
    assert_nil binary_search.locate_item(2)
    refute binary_search.exist?(2)
  end

  def test_finds_a_value_in_a_single_value_array
    # skip
    sorted_array = [1]
    binary_search = BinarySearch.new(sorted_array)
    assert_equal 0, binary_search.locate_item(1)
    assert binary_search.exist?(1)
  end

  def test_finds_a_value_in_a_dense_sorted_array
    # skip
    sorted_array = [1, 2, 3, 4, 5, 6]
    binary_search = BinarySearch.new(sorted_array)
    sorted_array.each_with_index do |value, index|
      assert_equal index, binary_search.locate_item(value)
      assert binary_search.exist?(value)
    end
  end

  def test_finds_a_value_in_a_sparse_sorted_array
    # skip
    sorted_array = [1, 5, 19, 57, 69, 88, 120, 145]
    binary_search = BinarySearch.new(sorted_array)
    sorted_array.each_with_index do |value, index|
      assert_equal index, binary_search.locate_item(value)
      assert binary_search.exist?(value)
    end
  end

  def test_finds_no_value_that_is_too_high
    # skip
    sorted_array = [1, 2, 3, 4, 5, 6]
    binary_search = BinarySearch.new(sorted_array)
    assert_nil binary_search.locate_item(7)
    assert_nil binary_search.locate_item(35)
    refute binary_search.locate_item(7)
    refute binary_search.locate_item(35)
  end

  def test_finds_no_value_that_is_too_small
    # skip
    sorted_array = [1, 2, 3, 4, 5, 6]
    binary_search = BinarySearch.new(sorted_array)
    assert_nil binary_search.locate_item(0)
    assert_nil binary_search.locate_item(-35)
    refute binary_search.locate_item(0)
    refute binary_search.locate_item(-35)
  end

end
