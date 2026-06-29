# frozen_string_literal: true

# A simple class to wrap a knapsack item
class KnapsackItem
  attr_reader :name, :weight, :value

  def initialize(name, weight, value)
    @name = name
    @weight = weight
    @value = value
  end

end

# A simple class to wrap the knapsack, with a specific capacity and the items it contains
class Knapsack
  attr_accessor :items

  def initialize(capacity)
    @capacity = capacity
    @items = []
  end

  def to_s
    "#{total_weight}/#{@capacity} valued at: #{value_of_contents}"
  end

  def value_of_contents
    @items.sum(&:value)
  end

  def total_weight
    @items.sum(&:weight)
  end

end

# A simple class to wrap the data held in each cell of the dynamic programming algorithm
class DynamicProgrammingKnapsackData
  attr_accessor :items

  def initialize
    @items = []
  end

  def add_items(other)
    other.items.each do |item|
      @items << item
    end
  end

  def add_item(item)
    @items << item
  end

  def remove_item(item)
    @items.delete(item)
  end

  def value
    @items.sum(&:value)
  end

  def to_s
    "#{@items.map(&:name).join(',')} #{value}"
  end

end

# A dynamic programming algorithm that finds the best way to fill the knapsack based on its capacity
# and the weight/value of items to choose from. Note if there is more than one optimal solution, the first will be selected.
module DynamicProgrammingKnapsack

  # Fills and returns a knapsack with a given capacity with knapsack items from the list of available items
  # prioritizing value of an item and then its weight where applicable.
  def self.fill(available_items, capacity)
    knapsack = Knapsack.new(capacity)

    # Defensive return empty knapsack if capacity is 0 or less
    return knapsack if capacity.zero? || capacity.negative?

    # Defensive return empty knapsack when there are no items to select from
    return knapsack if available_items.nil? || available_items.empty?

    # Unlike a greedy algorithm we do not care about the order the items are in
    # Instead we need a 2D grid, 1 row per item, 1 column per weight
    dp_grid = []
    available_items.size.times { dp_grid << Array.new(capacity) { DynamicProgrammingKnapsackData.new } }

    # for each of the available items we will fill its row
    available_items.each.with_index do |item, row_index|

      # for each weight of knapsacks from 1 to the actual knapsack weight
      (0...capacity).each.with_index do |_, col_index|

        # enable this to see the process in action
        #puts "Checking #{item.name} #{item.weight} #{item.value} against #{col_index}"

        # get the previous value from the row/column above
        previous_max_ksdata = prev_row_max(dp_grid, row_index, col_index)
        previous_max_value = previous_max_ksdata.nil? ? 0 : previous_max_ksdata.value

        # get the value for the remaining space in the knapsack
        current_max_ksdata = prev_row_remaining_space_worth(dp_grid, row_index, col_index, item)
        current_max_value = item.value + (current_max_ksdata.nil? ? 0 : current_max_ksdata.value)

        if item.weight > (col_index + 1)
          # item is too heavy, so this cell will be set the prev max's items or left empty
          dp_grid[row_index][col_index].add_items(previous_max_ksdata) unless previous_max_ksdata.nil?
        elsif previous_max_value > current_max_value
          # this cell will be set to the prev max's item
          dp_grid[row_index][col_index].add_items(previous_max_ksdata)
        else
          # this cell  will be set to the current item plus the other cell's items
          dp_grid[row_index][col_index].add_items(current_max_ksdata) unless current_max_ksdata.nil?
          dp_grid[row_index][col_index].add_item(item)
        end

        # enable these to see the process in action
        #print_grid(dp_grid)

      end
    end

    # The answer to what is included in the knapsack is in the last row's last column
    knapsack.items = dp_grid[available_items.size-1][capacity-1].items
    knapsack
  end

  # handle the potential out of bounds/nil aspects of looking up items in a grid
  private_class_method def self.prev_row_max(dp_grid, row_index, col_index)
    prev_row_index = row_index - 1
    if prev_row_index.negative?
      nil
    else
      dp_grid[prev_row_index][col_index]
    end
  end

  # handle the potential out of bounds/nil aspects of looking up items in a grid
  private_class_method def self.prev_row_remaining_space_worth(dp_grid, row_index, col_index, item)
    prev_row_index = row_index - 1
    prev_col_index = col_index - item.weight
    if prev_row_index.negative? || prev_col_index.negative?
      nil
    else
      dp_grid[prev_row_index][prev_col_index]
    end
  end

  # A way to emit the dynamic programming grid in a more readable manner to understand what it is doing on each iteration.
  private_class_method def self.print_grid(dp_grid)
    puts '_________________________'
    dp_grid.each_with_index do |row, index|
      puts "--- row: #{index} ---"
      puts row.map(&:to_s).join('  |  ')
    end
  end

end
