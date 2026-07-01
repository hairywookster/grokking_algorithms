# frozen_string_literal: true

# A dynamic programming algorithm that finds the number of letters in a sequence that the two strings
# A sequence in this sense does not mean an unbroken sequence (that is a substring instead)
# Example FISH and FOSH have the sequence F*SH so have a subsequence of three.
module DynamicProgrammingLongestCommonSubsequence

  # Calculates the length of the longest common subsequence between the supplied strings
  def self.find_longest_common_subsequence(string1, string2)
    # Defensive return 0 if either string supplied is nil or empty
    return nil if string1.nil? || string2.nil? || string1.empty? || string2.empty?

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
          dp_grid[row_index][col_index] = max_of_prev_cell_or_neighbour_above(dp_grid, row_index, col_index)
        end

        # enable these to see the process in action
        # print_grid(dp_grid)
      end
    end

    # The length can be determined by finding the highest number in the 2d grid
    longest_common_subsequence_length = dp_grid.map { |row| row.max }.max

    # We can use the length above to determine if we run the code below
    longest_common_subsequence_length.zero? ? '' : backtrack_to_subsequence(dp_grid, string1, string2)
  end

  # determines the exact subsequence we collected
  private_class_method def self.backtrack_to_subsequence(dp_grid, string1, string2)
    s1 = string1.size - 1
    s2 = string2.size - 1
    longest_common_subsequence = []

    while s1 >= 0 && s2 >= 0
      if string1[s1] == string2[s2]
        # Characters match, the character is part of the subsequence.
        # Move diagonally up-left.
        longest_common_subsequence << string1[s1]
        s1 -= 1
        s2 -= 1
      elsif s1.zero?
        # were at top row, we can only move left
        s2 -= 1
      elsif s2.zero?
        s1 -= 1
      elsif dp_grid[s1-1][s2] >= dp_grid[s1][s2-1]
        # Top neighbour is larger (or equal), so move up
        s1 -= 1
      else
        # Left neighbour is larger, so move left
        s2 -= 1
      end
    end

    longest_common_subsequence.reverse.join
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

  private_class_method def self.max_of_prev_cell_or_neighbour_above(dp_grid, row_index, col_index)
    # row above
    prev_row_index = row_index - 1
    # col to left
    prev_col_index = col_index - 1
    # determine value of neighbour above
    above_value = 0
    above_value = dp_grid[prev_row_index][col_index] unless prev_row_index.negative?
    # determine value of neighbour to left
    left_value = 0
    left_value = dp_grid[row_index][prev_col_index] unless prev_col_index.negative?
    # use the value that has the highest value of these two
    [above_value, left_value].max
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
