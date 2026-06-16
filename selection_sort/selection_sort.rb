# frozen_string_literal: true

# A class that wraps the process of performing a selection sort
# Warning - Do not use this class for anything real...
#
# This algorithm runs in O(n x n)
#
# This means that the algorithm is very slow compare to other sort algorithms.
# It's interesting from a base point though as it is most akin to what we as a human would do when performing a simple sort
#
module SelectionSort

  def self.sort(list)
    apply_sort(list, :<)
  end

  def self.reverse_sort(list)
    apply_sort(list, :>)
  end

  def self.apply_sort(list, comparison_operator)
    # return nil or empty list if either condition is true
    return list if list.nil? || list.empty?

    # create a new list to store the sorted contents
    sorted_list = []
    # duplicate the list so we do not impact the original list
    list_dup = list.dup
    # iterate over the placement algorithm n times, where n is the size of the list were sorting
    list.size.times do |_|
      place_next_item(list_dup, sorted_list, comparison_operator)
    end
    sorted_list
  end

  # On each successive call to this method the supplied list becomes one element shorter
  def self.place_next_item(list, sorted_list, comparison_operator)
    # set the smallest item and smallest index to the first item in the list
    smallest_item = list.first
    smallest_index = 0
    # iterate through the list and find the smallest item through a series of comparisons.
    list.each_with_index do |item, index|
      # apply the comparison, note this essentially boils down to item < smallest_item   or   item > smallest_item
      if item.send(comparison_operator, smallest_item)
        smallest_item = item
        smallest_index = index
      end
    end
    # remove the smallest item and add it to the sorted list
    sorted_list << list.delete_at(smallest_index)
  end

  private_class_method :place_next_item, :apply_sort

end
