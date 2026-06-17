# A class that wraps the process of performing a binary search on a sorted array.
# Note it does not check that the array is sorted.
#
# This algorithm runs in O(log n)  - logarithmic time.
# This means that the algorithm continues to scale well with much larger volumes of data.
# For example
# 1 million items in the array will require at most - 20 steps
#      20 steps - is  2 to the power of 20
#      In plain English we would need to multiply 2 by itself 20 times to reach a number just slightly larger than 1 million.
# Compare this to
# Simple linear search  - O(n)
# 1 million items in the array would require - 1 million steps
#
# Remember that Big O is a measure of the growth of how many steps are required and how the number of items impacts the overall speed to compute.
#
class BinarySearch

  # Note this class could/should be refactored to a module both for ease of use and reduced state holding.
  # Essentially class -> module, delete initializer, pass sorted_array to both methods, update tests.
  def initialize(sorted_array)
    @sorted_array = sorted_array
  end

  def locate_item(value)
    # return nil if the array was nil or the array was empty
    return nil if @sorted_array.nil? || @sorted_array.empty?

    # Not strictly necessary but provides a quicker exit for cases where the value is never going to be found
    return nil if value < @sorted_array.first || value > @sorted_array.last

    # The initial left point we check from is index 0, the highest right point is the last index
    low_index = 0
    high_index = @sorted_array.length - 1

    # Continue looking for the value until we find the item, or we have checked the very last index (where low == high)
    while low_index <= high_index
      # Split the remaining items in the array in half - at the halfway point between low and high indexes.
      mid_index = (low_index + high_index) / 2
      # grab the item at the middle and compare it with the value we were looking for
      mid_value = @sorted_array[mid_index]
      return mid_index if mid_value == value

      # The value did not match so we need to exclude the half that was too low or too high.
      value > mid_value ? low_index = mid_index + 1 : high_index = mid_index - 1
    end

    # we did not find the value so return nil as an indicator that the value's index in the array could not be located
    nil
  end

  def exist?(value)
    # A convenience method for cases where we do not care about the index, just whether the item is present or not.
    # Of course if that is the case it would be better to use a hash based algorithm/data structure instead.
    !locate_item(value).nil?
  end

end
