# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'selection_sort'

class SelectionSortTest < Minitest::Test

  def test_sorts_an_empty_list
    # skip
    empty_list = []
    algorithm_sorted_list = SelectionSort.sort(empty_list)
    assert_empty algorithm_sorted_list
  end

  def test_sorts_a_nil_list
    # skip
    empty_list = nil
    algorithm_sorted_list = SelectionSort.sort(empty_list)
    assert_nil algorithm_sorted_list
  end

  def test_reverse_sorts_an_empty_list
    # skip
    empty_list = []
    algorithm_sorted_list = SelectionSort.reverse_sort(empty_list)
    assert_empty algorithm_sorted_list
  end

  def test_reverse_sorts_a_nil_list
    # skip
    empty_list = nil
    algorithm_sorted_list = SelectionSort.reverse_sort(empty_list)
    assert_nil algorithm_sorted_list
  end

  def test_sorts_an_already_sorted_list
    # skip
    sorted_list = [1, 2, 3, 4, 5, 6]
    algorithm_sorted_list = SelectionSort.sort(sorted_list)
    assert_equal sorted_list, algorithm_sorted_list
  end

  def test_reverse_sorts_an_already_sorted_list
    # skip
    sorted_list = [1, 2, 3, 4, 5, 6]
    algorithm_sorted_list = SelectionSort.reverse_sort(sorted_list)
    assert_equal sorted_list.reverse, algorithm_sorted_list
  end

  def test_sorts_an_unsorted_list
    # skip
    unsorted_list = [3, 5, 7, 1, 2, 3]
    algorithm_sorted_list = SelectionSort.sort(unsorted_list)
    assert_equal [1,2,3,3,5,7], algorithm_sorted_list
  end

  def test_reverse_sorts_an_unsorted_list
    # skip
    unsorted_list = [3, 5, 7, 1, 2, 3]
    algorithm_sorted_list = SelectionSort.reverse_sort(unsorted_list)
    assert_equal [1,2,3,3,5,7].reverse, algorithm_sorted_list
  end

  def test_sorts_an_unsorted_list_of_non_integers
    # skip
    unsorted_list = %w[hello goodbye zoo pete cheese]
    algorithm_sorted_list = SelectionSort.sort(unsorted_list)
    assert_equal %w[cheese goodbye hello pete zoo], algorithm_sorted_list
  end

  def test_reverse_sorts_an_unsorted_list_of_non_integers
    # skip
    unsorted_list = %w[hello goodbye zoo pete cheese]
    algorithm_sorted_list = SelectionSort.reverse_sort(unsorted_list)
    assert_equal %w[cheese goodbye hello pete zoo].reverse, algorithm_sorted_list
  end

end
