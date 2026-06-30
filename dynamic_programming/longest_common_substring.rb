# frozen_string_literal: true

# A dynamic programming algorithm that finds the length of the longest common substring between two strings
module DynamicProgrammingLongestCommonSubstring

  # Calculates the length of the longest common substring between the supplied strings
  def self.length(string1, string2)
    # Defensive return 0 if either string supplied is nil or empty
    return 0 if string1.nil? || string2.nil? || string1.empty? || string2.empty?

    # We need a 2D grid to house the rows (letters from string1) and columns (letters from string2)
    dp_grid = []
    columns = []
    string2.length.times { columns << -1 }
    string1.length.times { dp_grid << columns.dup }

    # enable this to see the process in action
    #puts "grid before starting"
    #print_grid(dp_grid)

    # for each of the characters in the string1
    string1.each_char.with_index do |string1_char, row_index|
      # for each of the characters in the string2
      string2.each_char.with_index do |string2_char, col_index|

        # enable this to see the process in action
        #puts "Checking #{string1_char} vs #{string2_char} --- r:#{row_index} c:#{col_index}"

        if string1_char == string2_char
          dp_grid[row_index][col_index] = 1 + neighbour_above_lefts_value(dp_grid, row_index, col_index)
        else
          dp_grid[row_index][col_index] = 0
        end

        # enable these to see the process in action
        #print_grid(dp_grid)
      end
    end

    # The length can be determined by finding the highest number in the 2d grid if that is all that is required
    #longest_common_substring_length = dp_grid.map {|row| row.max }.max

    backtrack_to_substring(dp_grid, string1, string2)
  end


  private_class_method def self.find_max_value_and_index(dp_grid)
    max_value = 0
    max_row = 0
    max_col = 0
    dp_grid.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        if dp_grid[row_index][col_index] > max_value
          max_value = dp_grid[row_index][col_index]
          max_row = row_index
          max_col = col_index
        end
      end
    end
    [max_value, max_row, max_col]
  end

  # Determines the longest substring using backtrack of the dp_grid
  private_class_method def self.backtrack_to_substring(dp_grid, string1, string2)
    # find the max length of substring from the dp_grid and its row/col index (location in grid)
    max_value, max_row, max_col = find_max_value_and_index(dp_grid)

    # defensive return 0 if there is no substring
    return '' if max_value.zero?

    longest_common_substring = []

    while max_value > 0
      longest_common_substring << string1[max_row]
      # Move diagonally up-left.
      max_row -= 1
      max_col -= 1
      max_value = dp_grid[max_row][max_col]
    end

    longest_common_substring.reverse.join
  end

  # handle the potential out of bounds/nil aspects of looking up cells in a grid
  private_class_method def self.neighbour_above_lefts_value(dp_grid, row_index, col_index)
    # row above
    prev_row_index = row_index - 1
    # col to left
    prev_col_index = col_index - 1
    if prev_row_index.negative? || prev_col_index.negative?
      0
    else
      dp_grid[prev_row_index][prev_col_index]
    end
  end

  # A way to emit the dynamic programming grid in a more readable manner to understand what it is doing on each iteration.
  private_class_method def self.print_grid(dp_grid)
    puts "_________________________"
    dp_grid.each_with_index do |row, index|
      puts "--- row: #{index} ---"
      puts row.map(&:to_s).join("  |  ")
    end
  end

end
