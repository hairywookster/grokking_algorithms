# frozen_string_literal: true

# A simple class to wrap a travel itinerary attraction item
class AttractionItem
  attr_reader :name, :time_required, :value

  def initialize(name, time_required, value)
    @name = name
    @time_required = time_required
    @value = value
  end

  def to_s
    "#{@name} time_required=#{@time_required} value=#{@value}"
  end

end

# A simple class to wrap the travel itinerary, with a specific maximum time available
class TravelItinerary
  attr_accessor :attractions

  def initialize(max_time_available)
    @max_time_available = max_time_available
    @attractions = []
  end

  def to_s
    "#{time_used_by_attractions}/#{@max_time_available}"
  end

  def time_used_by_attractions
    @attractions.sum(&:time_required)
  end

end

# A simple class to wrap the data held in each cell of the dynamic programming algorithm
class DynamicProgrammingTravelItineraryData
  attr_accessor :attractions

  def initialize
    @attractions = []
  end

  def add_attractions(other)
    other.attractions.each do |attraction|
      @attractions << attraction
    end
  end

  def add_attraction(attraction)
    @attractions << attraction
  end

  def remove_attraction(attraction)
    @attractions.delete(attraction)
  end

  def total_value
    @attractions.sum(&:value)
  end

  def total_time_required
    @attractions.sum(&:time_required)
  end

  def to_s
    "#{@attractions.map(&:name).join(',')}  #{total_time_required}:#{total_value}"
  end

end

# A dynamic programming algorithm that finds the best way to fill the travel itinerary based on its max time available
# and the time_taken/value of attraction items to choose from. Note if there is more than one optimal solution, the first will be selected.
module DynamicProgrammingTravelItinerary

  # Fills and returns a travel itinerary with a given max amount of available time with attractions items from the list of available attractions
  # prioritizing the value(rating) of an attraction and time required where applicable.
  def self.select(available_attractions, max_days_available)
    travel_itinerary = TravelItinerary.new(max_days_available)

    # Defensive return empty travel itinerary if max_days_available is 0 or less
    return travel_itinerary if max_days_available.zero? || max_days_available.negative?

    # Defensive return empty travel itinerary when there are no items to select from
    return travel_itinerary if available_attractions.nil? || available_attractions.empty?

    # Unlike a greedy algorithm we do not care about the order the items are in
    # Instead we need a 2D grid, 1 row per item, 1 column per time required
    dp_grid = []

    # work out how many half day increments we have for the columns
    half_day_increments = (max_days_available / 0.5).to_i
    time_taken_columns = []
    half_day_increments.times.each { |index| time_taken_columns << (0.5 * (index + 1)) }

    available_attractions.size.times { dp_grid << Array.new(half_day_increments) { DynamicProgrammingTravelItineraryData.new } }

    # for each of the available attractions we will fill its row
    available_attractions.each.with_index do |attraction, row_index|

      # for each half day increment from 0.5 to the actual travel itinerary max days
      time_taken_columns.each.with_index do |increment, col_index|

        # enable this to see the process in action
        #puts "Checking #{attraction}  ---  col:#{col_index}  time:#{increment}"

        # get the previous total_value from the row/column above
        previous_max_data = prev_row_max(dp_grid, row_index, col_index)
        previous_max_value = previous_max_data.nil? ? 0 : previous_max_data.total_value

        # get the value for the remaining time available in the travel itinerary
        current_max_data = prev_row_remaining_space_worth(dp_grid, row_index, col_index, attraction)
        current_max_value = attraction.value + (current_max_data.nil? ? 0 : current_max_data.total_value)
        current_max_time = attraction.time_required + (current_max_data.nil? ? 0 : current_max_data.total_time_required)

        if attraction.time_required > increment || current_max_time > increment
          # attraction takes too long, so this cell will be set the prev max's attractions or left empty
          dp_grid[row_index][col_index].add_attractions(previous_max_data) unless previous_max_data.nil?
        elsif previous_max_value > current_max_value
          # this cell will be set to the prev max's attractions
          dp_grid[row_index][col_index].add_attractions(previous_max_data)
        else
          # this cell will be set to the current attraction plus the other cell's attractions
          dp_grid[row_index][col_index].add_attractions(current_max_data) unless current_max_data.nil?
          dp_grid[row_index][col_index].add_attraction(attraction)
        end

        # enable these to see the process in action
        #print_grid(dp_grid)

      end
    end

    # The answer to what is included in the travel itinerary is in the last row's last column
    travel_itinerary.attractions = dp_grid[available_attractions.size - 1][time_taken_columns.size - 1].attractions
    travel_itinerary
  end

  # handle the potential out of bounds/nil aspects of looking up cells in a grid
  private_class_method def self.prev_row_max(dp_grid, row_index, col_index)
    prev_row_index = row_index - 1
    if prev_row_index.negative?
      nil
    else
      dp_grid[prev_row_index][col_index]
    end
  end

  # handle the potential out of bounds/nil aspects of looking up cells in a grid
  private_class_method def self.prev_row_remaining_space_worth(dp_grid, row_index, col_index, attraction)
    prev_row_index = row_index - 1
    # this requires a conversion of time_required to column
    prev_col_index = col_index - (attraction.time_required / 0.5).to_i
    if prev_row_index.negative? || prev_col_index.negative?
      nil
    else
      dp_grid[prev_row_index][prev_col_index]
    end
  end

  # Emit the dynamic programming grid in a more readable manner to understand what it is doing on each iteration.
  private_class_method def self.print_grid(dp_grid)
    puts "_________________________"
    dp_grid.each_with_index do |row, index|
      puts "--- row: #{index} ---"
      puts row.map(&:to_s).join("  |  ")
    end
  end

end
