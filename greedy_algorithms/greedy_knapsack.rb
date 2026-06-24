# frozen_string_literal: true

# A simple class to wrap a knapsack item
class KnapsackItem
  attr_reader :name, :weight, :value, :used
  attr_writer :used

  def initialize(name, weight, value)
    @name = name
    @weight = weight
    @value = value
    @used = false
  end

end

# A simple class to wrap the knapsack, with a specific capacity and the items it contains
class Knapsack
  attr_reader :items

  def initialize(capacity)
    @capacity = capacity
    @capacity = 0 if @capacity.negative?
    @total_weight = 0
    @items = []
  end

  def empty?
    @items.empty?
  end

  def to_s
    "#{@total_weight}/#{@capacity} valued at: #{value_of_contents}"
  end

  def value_of_contents
    @items.sum(&:value)
  end

  def add_item(item)
    @items << item
    @total_weight += item.weight
  end

  def remaining_capacity
    @capacity - @total_weight
  end
  def full?
    remaining_capacity.zero?
  end

  def can_hold?( item )
    item.weight <= remaining_capacity
  end

end

# A simple greedy algorithm which finds an approximate answer to filling the knapsack.
# This is not necessarily or even likely to tbe the optimal solution (that requires dynamic programming)
module GreedyKnapsack

  # Fills and returns a knapsack with a given capacity with knapsack items from the list of available items
  # prioritizing value of an item and then its weight where applicable.
  def self.fill(available_items, capacity)
    knapsack = Knapsack.new(capacity)

    # Defensive return empty knapsack when there are no items to select from
    return knapsack if available_items.nil? || available_items.empty?

    # Duplicate the list of available items
    all_items = available_items.dup
    # sort by highest value descending
    all_items.sort! { |a,b| b.value <=> a.value }

    #find the next most valuable item that can fit into the knapsack
    next_item_to_add = find_next_most_valuable_fitting_item(knapsack, all_items)

    # repeat this process until we run out of items or the knapsack is full
    while next_item_to_add
      # add the item to the knapsack
      knapsack.add_item(next_item_to_add)
      next_item_to_add = find_next_most_valuable_fitting_item(knapsack, all_items)
    end

    knapsack
  end

  # finds the next most valuable unused item that fits in the knapsack
  private_class_method def self.find_next_most_valuable_fitting_item(knapsack, all_items)
    unless knapsack.full?
      all_items.each do |item|
        if !item.used && knapsack.can_hold?( item )
          # mark the item as having been used
          item.used = true
          return item
        end
      end
    end
    nil
  end

end
