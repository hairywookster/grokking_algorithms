# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'depth_first_search'

class DepthFirstSearchTest < Minitest::Test

  def available_methods
    %i[visit_inorder visit_preorder visit_postorder]
  end

  def test_visits_nodes_in_correct_order_for_nil_graph
    # skip
    nil_graph = nil
    available_methods.each do |order_method|
      nodes_visited = DepthFirstSearch.send(order_method, nil_graph)
      assert_empty nodes_visited
    end
  end

  def test_visits_nodes_in_correct_order_for_empty_graph
    # skip
    empty_graph = {}
    available_methods.each do |order_method|
      nodes_visited = DepthFirstSearch.send(order_method, empty_graph)
      assert_empty nodes_visited
    end
  end

  def test_visits_nodes_in_correct_in_order_for_graph
    graph = { "pete" => ["bob", "carol"], "bob" => ["jane", nil], "carol" => [nil, nil], "jane" => [nil, nil] }
    nodes_visited = DepthFirstSearch.visit_inorder(graph)
    assert_equal %w[jane bob pete carol], nodes_visited
  end

  def test_visits_nodes_in_correct_pre_order_for_graph
    graph = { "pete" => ["bob", "carol"], "bob" => ["jane", nil], "carol" => [nil, nil], "jane" => [nil, nil] }
    nodes_visited = DepthFirstSearch.visit_preorder(graph)
    assert_equal %w[pete bob jane carol], nodes_visited
  end

  def test_visits_nodes_in_correct_post_order_for_graph
    graph = { "pete" => ["bob", "carol"], "bob" => ["jane", nil], "carol" => [nil, nil], "jane" => [nil, nil] }
    nodes_visited = DepthFirstSearch.visit_postorder(graph)
    assert_equal %w[jane bob carol pete], nodes_visited
  end

end
