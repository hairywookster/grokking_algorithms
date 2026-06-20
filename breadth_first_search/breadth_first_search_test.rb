# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'breadth_first_search'

class BreadthFirstSearchTest < Minitest::Test

  def test_goal_not_found_in_a_nil_graph
    # skip
    nil_graph = nil
    goal_located = BreadthFirstSearch.search('pete', 'jane', nil_graph)
    assert_nil goal_located
  end

  def test_goal_not_found_in_an_empty_graph
    # skip
    empty_graph = {}
    goal_located = BreadthFirstSearch.search('pete', 'jane', empty_graph)
    assert_nil goal_located
  end

  def test_goal_not_found_in_a_non_startable_graph
    # skip
    graph = { "dave" => ["bob"] }
    goal_located = BreadthFirstSearch.search('pete', 'jane', graph)
    assert_nil goal_located
  end

  def test_goal_not_found_in_a_graph
    # skip
    graph = { "pete" => ["bob"] }
    goal_located = BreadthFirstSearch.search('pete', 'jane', graph)
    assert_nil goal_located
  end

  def test_path_doesnt_exist_in_a_graph
    # skip
    graph = { "pete" => ["bob"] }
    path_exists = BreadthFirstSearch.path_exists?('pete', 'jane', graph)
    refute path_exists
  end

  def test_goal_found_in_a_small_graph_with_missing_referenced_nodes
    # skip
    graph = { "pete" => ["bob"], "bob" => ["jane", "mark"], "jane" => ["bob"] }
    goal_located = BreadthFirstSearch.search('pete', 'jane', graph)
    assert_equal %w[bob jane], goal_located
  end

  def test_path_exists_in_a_small_graph_with_missing_referenced_nodes
    # skip
    graph = { "pete" => ["bob"], "bob" => ["jane", "mark"], "jane" => ["bob"] }
    path_exists = BreadthFirstSearch.path_exists?('pete', 'jane', graph)
    assert path_exists
  end
end
