# frozen_string_literal: true

# Some contrived / simple recursion examples demonstrating how some problems can be tackled.
# 
# This strategy is known as the Divide and Conquer
# 
# The goal of Divide and Conquer is to determine (slight expansion by me)
# - defensive cases : Cases where there is no work to do
# - base case       : Determine the smallest amount or last thing to process in case of lists/arrays
# - recursive case  : Determine the aspect that needs to be further reduced to move it towards the base case
# 
module RecursionExamples

  # An Algorithm to sum up the numbers in a list.
  # The algorithm recursively calls itself with a successively smaller list each time.
  # When it reaches the base case, it returns the base case value to the caller,
  # which then returns its value, and so on up the call stack to generate the final sum.
  # In ruby, assuming an array, we would normally just do, list.sum
  def self.sum(list)
    # return nil if the list we received was nil
    return nil if list.nil?
    # return 0 if the list we received was empty
    return 0 if list.empty?
    # base case - return the first element if the list is down to one element
    return list.first if list.size == 1

    # recursive case - otherwise return the sum of the first element plus the sum of everything else,
    # chopping off the first item from the list to move the list towards the base case.
    # IMPORTANT NOTE : this can be optimized by passing in the current left most index so as not to create subsequent sub-arrays each call
    list.first + sum(list[1..-1])
  end

  # An algorithm to calculate the factorial of a number
  # A factorial of a number is essentially the specified number multiplied by each successive number, i.e.
  # 5! = 5 * 4 * 3 * 2 * 1
  # This algorithm uses recursion to determine the total
  # In ruby we would most likely just do,  (1..number).inject(1, :*)
  def self.factorial(number)
    # defensive case - there is nothing to calculate
    return nil if number.nil?
    # defensive case - the factorial total will be 0
    return 0 if number.zero?

    # base case - we have reached the smallest case of 1
    return 1 if number == 1

    # recursive case - otherwise return the current n multiplied by the result of the remaining numbers
    # so if we start at 5 , it will be 5 * (factorial of 5-1), next call will be 4 * (factorial of 4-1) and so on
    number * factorial(number - 1)
  end

  # An algorithm to determine the max number in a list using recursion
  # In ruby, assuming an array, we would normally just do, list.max
  def self.max(list)
    # defensive case - there is no max in a nil or empty list
    return nil if list.nil? || list.empty?

    # base case - we have reached the end of the list - return the value for comparison by the previous caller
    return list.first if list.size == 1

    # recursive case - we need to get the next value for the comparison
    # IMPORTANT NOTE : this can be optimized by passing in the current left most index so as not to create subsequent sub-arrays each call
    remaining_max = max(list[1..-1])
    list.first > remaining_max ? list.first : remaining_max
  end

  # An algorithm to determine the min number in a list using recursion
  # In ruby, assuming an array, we would normally just do, list.min
  def self.min(list)
    # defensive case - there is no min in a nil or empty list
    return nil if list.nil? || list.empty?

    # base case - we have reached the end of the list - return the value for comparison by the previous caller
    return list.first if list.size == 1

    # recursive case - we need to get the next value for the comparison
    # IMPORTANT NOTE : this can be optimized by passing in the current left most index so as not to create subsequent sub-arrays each call
    remaining_min = min(list[1..-1])
    list.first < remaining_min ? list.first : remaining_min
  end


  # An algorithm to determine the size of a list using recursion
  # In ruby, assuming an array, we would normally just do, list.size or list.length
  def self.size(list)
    # defensive case - there is no min in a nil
    return nil if list.nil?
    # defensive case - there is zero items in an empty list
    return 0 if list.empty?

    # base case - we have reached the end of the list - return a 1 count
    return 1 if list.size == 1

    # recursive case - we need to increment the count of elements through further recursive calls
    # IMPORTANT NOTE : this can be optimized by passing in the current left most index so as not to create subsequent sub-arrays each call
    1 + size(list[1..-1])
  end

end
