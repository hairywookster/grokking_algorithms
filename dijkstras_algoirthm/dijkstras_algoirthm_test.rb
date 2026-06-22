# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'dijkstras_algoirthm'

class DijkstrasAlgoirthmTest < Minitest::Test

  def test_finds_most_efficient_path_with_empty_graphs
    # skip
    nil_graph = nil
    empty_graph = {}
    graphs = [nil_graph, empty_graph]
    start_node = 'book'
    goal_node = 'piano'
    graphs.each do |graph|
      result = DijkstrasAlgoirthm.find_most_efficient_path(graph, start_node, goal_node)
      assert_nil result.path_taken
      assert_nil result.cost
    end
  end

  def test_finds_most_efficient_path_with_missing_start_node
    # skip
    graph = { 'piano' => {} }
    start_node = 'book'
    goal_node = 'piano'
    assert_raises ArgumentError do
      DijkstrasAlgoirthm.find_most_efficient_path(graph, start_node, goal_node)
    end
  end

  def test_finds_most_efficient_path_with_missing_goal_node
    # skip
    graph = { 'book' => {} }
    start_node = 'book'
    goal_node = 'piano'
    assert_raises ArgumentError do
      DijkstrasAlgoirthm.find_most_efficient_path(graph, start_node, goal_node)
    end
  end


  def test_finds_most_efficient_path_with_good_graph
    # skip
    graph = { 'book' => { 'lp' => 5, 'poster' => 0},
              'lp' => {'drum' => 20, 'bass' => 15 },
              'poster' => { 'bass' => 30, 'drum' => 35 },
              'bass' => { 'piano' => 20},
              'drum' => { 'piano' => 10 },
              'piano' => {} }

    start_node = 'book'
    goal_node = 'piano'
    result = DijkstrasAlgoirthm.find_most_efficient_path(graph, start_node, goal_node)
    assert_equal 35, result.cost
    assert_equal %w[book lp drum piano], result.path_taken
  end

end
