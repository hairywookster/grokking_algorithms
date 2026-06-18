# frozen_string_literal: true

# A class that wraps the process of performing a quick sort
#
# This algorithm runs in O(n log n)
#
# This means that the algorithm is much faster than selection sort and handles data growth well.
#
module QuickSort

  def self.sort(list)
    quicksort(list, :<=)
  end

  def self.reverse_sort(list)
    quicksort(list, :>=)
  end

  # A recursive method which will be called with smaller and smaller lists, breaking down the task of sorting the
  # fuller list into smaller pieces.
  # Note supplying the comparison_operator allows us to specify the order of sorted results
  # :<=  gives us ascending order 1,2,3,...
  # :>=  gives us descending order 10,9,8,...
  # This avoids duplicating code for reverse order sort
  # doing a separate O(n) operation to reverse the sorted list.
  #
  private_class_method def self.quicksort(list, comparison_operator)
    # defensive case - there is no list or the list is empty
    return list if list.nil? || list.empty?

    # base case
    return list if list.size == 1

    # recursive case
    # Pick a random pivot point - the first element in an unsorted list is just as likely to be a good choice as any other.
    pivot_value = list.first

    # Create two arrays to contain the items that were less than and greater than the pivot value
    left_side = []
    right_side = []
    list.each_with_index do |item, index|
      # Now partition the list's items into the two lists whilst ignoring our pivot's index
      # Note the item.send(...) is just the same as doing item <= pivot_value  or  item >= pivot_value
      (item.send(comparison_operator, pivot_value) ? left_side << item : right_side << item) unless index.zero?
    end

    # Call our method again with both sets of data and concatenate the results on either side of the pivot's value
    quicksort(left_side, comparison_operator).concat([pivot_value]).concat(quicksort(right_side, comparison_operator))
  end

end
