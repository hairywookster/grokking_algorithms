# frozen_string_literal: true

# A simple algorithm to greedily cover a specific set of items when given a number of subsets to choose from.
module GreedySetCover

  # Determines a list of subsets that will cover the entire set of items contained within all the subsets.
  # An example would be picking the best radio stations to cover each state in America,
  # where each radio station covers n states.
  def self.cover(available_sets)
    return [] if available_sets.nil? || available_sets.empty?

    # store the names of the sets we have selected to provide coverage of all of the items
    covered_by = []

    # if we want to know what was covered - enable this to remember them
    #covered = Set.new

    # determine all the items to be covered
    remaining_items = available_sets.inject(Set.new) do |accumulator, (_, items)|
      accumulator + items
    end

    # repeat until we have run out of subsets or, no remaining subset adds anything useful
    loop do
      # find the next subset we should use
      next_set_to_use = find_next_set_to_use(remaining_items, available_sets, covered_by)

      # exit the loop if we have nothing useful to add
      break if next_set_to_use.nil?

      # add the subset name
      covered_by << next_set_to_use

      # subtract the items covered from the remaining items to be covered
      remaining_items -= available_sets[next_set_to_use]

      # if we want to know what was covered - enable this to remember them
      #covered += available_sets[next_set_to_use]

      # we have covered everything already so exit the loop
      break if remaining_items.empty?
    end

    covered_by
  end

  # Determines the next set that covers the most of the remaining items.
  private_class_method def self.find_next_set_to_use(remaining_items, available_sets, covered_by)
    items_covered_count = 0
    items_covered_by = nil

    # check each of the remaining available_sets for the set that covers the most amount of remaining items
    available_sets.each do |set_name, items|
      # skip the set if we have already chosen it earlier
      next if covered_by.include?(set_name)

      # calculate how many items this set covers (i.e. items are in both sets)
      items_covered = (remaining_items & items).size
      if items_covered > items_covered_count
        # it covers more so remember its name and the coverage count
        items_covered_count = items_covered
        items_covered_by = set_name
      end
    end

    items_covered_by
  end

end
