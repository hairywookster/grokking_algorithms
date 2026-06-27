# frozen_string_literal: true

# A k nearest neighbour algorithm that predicts how many loaves to bake based on the nearest 4 neighbours baked loaves
module BakeryNearestNeighbour

  # A simple class wrapping the features that are used to find the nearest neighbour, plus the number of loaves baked required for the prediction
  class BakeryDay
    attr_reader :loaves_baked, :game_on, :weekend_or_holiday, :weather

    def initialize(loaves_baked, game_on, weekend_or_holiday, weather)
      @loaves_baked = loaves_baked
      @game_on = game_on
      @weekend_or_holiday = weekend_or_holiday
      @weather = weather
    end

    # determine how close or far two neighbours are from each other
    def distance_between(other)
      # the formula should be
      # Math.sqrt( --code below-- )
      # but since distance is always positive, sorting by the squared distance
      # yields the same relative result for sort order
      (@weather-other.weather)**2 + (@game_on-other.game_on)**2 + (@weekend_or_holiday-other.weekend_or_holiday)**2
    end

    # sorts the list of other neighbours by how close or far they are from the bakery day we are predicting for.
    def sort_others( bakery_day_neighbour_list )
      bakery_day_neighbour_list.sort_by do |neighbour|
        distance_between(neighbour)
      end
    end

  end

  # Applies the algorithm to predict how many loaves to bake based on the 4 nearest neighbours.
  # 4 could be a much larger number dependent on the number of neighbours to compare against.
  # Most likely Math.sqrt(bakery_day_neighbour_list.size)
  def self.predict(bakery_day_neighbour_list, bakery_day_to_predict)
    # defensive return nil if nothing to work with
    return nil if bakery_day_neighbour_list.nil? || bakery_day_neighbour_list.empty?
    # defensive return nil if nothing to work with
    return nil if bakery_day_to_predict.nil?

    # sort the neighbours based on the distance between them and the bakery day to predict
    sorted_neighbours = bakery_day_to_predict.sort_others( bakery_day_neighbour_list )

    # return the number of loaves to bake by getting first 4 nearest neighbours, dividing their total loaves baked by 4
    (sorted_neighbours.first(4).sum(&:loaves_baked) / 4.0 ).round
  end

end
