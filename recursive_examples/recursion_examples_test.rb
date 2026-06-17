# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'recursion_examples'

class RecursionExamplesTest < Minitest::Test
  def test_sum_empty_list
    # skip
    empty_list = []
    summed = RecursionExamples.sum(empty_list)
    assert_equal 0, summed
  end

  def test_sum_nil_list
    # skip
    nil_list = nil
    summed = RecursionExamples.sum(nil_list)
    assert_nil summed
  end

  def test_sum_list
    # skip
    fuller_list = [1, 2, 3, 4, 5]
    summed = RecursionExamples.sum(fuller_list)
    assert_equal 15, summed
  end

  def test_factorial_of_nil
    nil_number = nil
    factorial = RecursionExamples.factorial(nil_number)
    assert_nil factorial
  end

  def test_factorial_of_zero
    number = 0
    factorial = RecursionExamples.factorial(number)
    assert_equal 0, factorial
  end

  def test_factorial_of_one
    number = 1
    factorial = RecursionExamples.factorial(number)
    assert_equal 1, factorial
  end

  def test_factorial_of_five
    number = 5
    factorial = RecursionExamples.factorial(number)
    assert_equal 120, factorial
  end

  def test_max_of_nil_list
    nil_list = nil
    max = RecursionExamples.max(nil_list)
    assert_nil max
  end

  def test_max_of_empty_list
    empty_list = []
    max = RecursionExamples.max(empty_list)
    assert_nil max
  end

  def test_max_of_fuller_list
    fuller_list = [156,34,10983,34,7,4,7363]
    max = RecursionExamples.max(fuller_list)
    assert_equal 10983, max
  end

  def test_min_of_nil_list
    nil_list = nil
    min = RecursionExamples.min(nil_list)
    assert_nil min
  end

  def test_min_of_empty_list
    empty_list = []
    min = RecursionExamples.min(empty_list)
    assert_nil min
  end

  def test_min_of_fuller_list
    fuller_list = [156,34,10983,34,7,4,7363]
    min = RecursionExamples.min(fuller_list)
    assert_equal 4, min
  end

  def test_size_of_nil_list
    nil_list = nil
    count = RecursionExamples.size(nil_list)
    assert_nil count
  end

  def test_size_of_empty_list
    empty_list = []
    count = RecursionExamples.size(empty_list)
    assert_equal 0, count
  end

  def test_size_of_fuller_list
    fuller_list = [156,34,10983,34,7,4,7363]
    count = RecursionExamples.size(fuller_list)
    assert_equal 7, count
  end

end
