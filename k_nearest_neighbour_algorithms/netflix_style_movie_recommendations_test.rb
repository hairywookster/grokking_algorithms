# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'netflix_style_movie_recommendations'

class NetflixStyleMovieRecommendationsTest < Minitest::Test

  def test_no_prediction_when_no_neighbours
    # skip
    nil_neighbours = nil
    empty_neighbours = []
    netflix_user = NetflixStyleMovieRecommendations::NetflixUser.new(3, 4, 4, 1, 4, [])
    neighbours = [nil_neighbours, empty_neighbours]
    neighbours.each do |netflix_neighbour_list|
      result = NetflixStyleMovieRecommendations.recommend_movies(netflix_neighbour_list, netflix_user)
      assert_nil result
    end
  end

  def test_no_prediction_when_no_netflix_user_to_predict
    # skip
    netflix_neighbour_list = [NetflixStyleMovieRecommendations::NetflixUser.new(3, 4, 4, 1, 4, [:movie1, :movie2, :movie3])]
    netflix_user = nil
    result = NetflixStyleMovieRecommendations.recommend_movies(netflix_neighbour_list, netflix_user)
    assert_nil result
  end

  def test_accurate_prediction
    # skip
    net1 = NetflixStyleMovieRecommendations::NetflixUser.new(5, 2, 5, 3, 1, [:movie1, :movie7, :movie13]) # selected third
    net2 = NetflixStyleMovieRecommendations::NetflixUser.new(2, 5, 1, 3, 1, [:movie3, :movie9, :movie15]) # selected fourth
    net3 = NetflixStyleMovieRecommendations::NetflixUser.new(1, 1, 5, 5, 2, [:movie4, :movie10, :movie16])
    net4 = NetflixStyleMovieRecommendations::NetflixUser.new(3, 3, 1, 1, 2, [:movie5, :movie11, :movie17]) # selected second
    net5 = NetflixStyleMovieRecommendations::NetflixUser.new(2, 2, 2, 5, 5, [:movie6, :movie12, :movie18])
    net6 = NetflixStyleMovieRecommendations::NetflixUser.new(4, 3, 5, 1, 5, [:movie2, :movie8, :movie14]) # selected first
    netflix_neighbour_list = [net1, net2, net3, net4, net5, net6]
    netflix_user = NetflixStyleMovieRecommendations::NetflixUser.new(3, 4, 4, 1, 4, [])
    result = NetflixStyleMovieRecommendations.recommend_movies(netflix_neighbour_list, netflix_user)
    assert_equal [:movie2, :movie8, :movie14, :movie5, :movie11, :movie17, :movie1, :movie7, :movie13, :movie3, :movie9, :movie15], result
  end

end