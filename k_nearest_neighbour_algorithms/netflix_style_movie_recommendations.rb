# frozen_string_literal: true

# A k nearest neighbour algorithm that predicts movie recommendations using the 4 nearest neighbours
module NetflixStyleMovieRecommendations

  # A simple class wrapping the features that are used to find the nearest neighbour, plus the movies that this netflix user likes
  class NetflixUser
    attr_reader :comedy, :action, :drama, :horror, :romance, :movie_list

    def initialize(comedy, action, drama, horror, romance, movie_list)
      @comedy = comedy
      @action = action
      @drama = drama
      @horror = horror
      @romance = romance
      @movie_list = movie_list
    end

    # determine how close or far two neighbours are from each other
    def distance_between(other)
      # the formula should be
      # Math.sqrt( --code below-- )
      # but since distance is always positive, sorting by the squared distance
      # yields the same relative result for sort order
      (@comedy - other.comedy)**2 + (@action - other.action)**2 + (@drama - other.drama)**2 +
        (@horror - other.horror)**2 + (@romance - other.romance)**2
    end

    # sorts the list of other neighbours by how close or far they are from the bakery day we are predicting for.
    def sort_others( netflix_neighbour_list )
      netflix_neighbour_list.sort_by do |neighbour|
        distance_between(neighbour)
      end
    end

  end

  # Applies the algorithm to predict bets movie recommendations for a netflix user based on the 4 nearest neighbours movies.
  # 4 would be a much larger number in real life, primarily dependent on the number of neighbours to compare against.
  # Most likely Math.sqrt(netflix_neighbour_list.size)
  def self.recommend_movies(netflix_neighbour_list, netflix_user)
    # defensive return nil if nothing to work with
    return nil if netflix_neighbour_list.nil? || netflix_neighbour_list.empty?
    # defensive return nil if nothing to work with
    return nil if netflix_user.nil?

    # sort our neighbours based on proximity to the netflix user
    neighbours = netflix_user.sort_others(netflix_neighbour_list)

    # determine the list of movies to recommend based on the movies from the nearest 4
    neighbours.first(4).map(&:movie_list).flatten
  end

end
