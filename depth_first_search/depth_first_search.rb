# frozen_string_literal: true

module DepthFirstSearch

  PRE_ORDER = :preorder
  POST_ORDER = :postorder
  IN_ORDER = :inorder

  # A Depth First algorithm that visits nodes in inorder
  def self.visit_inorder(graph)
    visit(graph, DepthFirstSearch::IN_ORDER)
  end

  # A Depth First algorithm that visits nodes in preorder
  def self.visit_preorder(graph)
    visit(graph, DepthFirstSearch::PRE_ORDER)
  end

  # A Depth First algorithm that visits nodes in postorder
  def self.visit_postorder(graph)
    visit(graph, DepthFirstSearch::POST_ORDER)
  end

  private_class_method def self.visit(graph, order=IN_ORDER)
    # Defensive - nothing to do if the graph is nil or empty
    return [] if graph.nil? || graph.empty?

    # Create an array to hold the nodes visited
    visited = []

    # Visit the first node
    visit_nodes(graph.keys.first, graph, visited, order)

    # Return the list of nodes that were visited in the order that they were processed
    visited
  end

  private_class_method def self.visit_nodes(current_node, graph, visited, ordering)
    # Defensive - the current node is nil
    return if current_node.nil?

    # Get the child nodes from the current_node
    current_nodes_children = graph[current_node]

    case ordering
    when PRE_ORDER
      # Collect the current node
      visited << current_node
      # Collect the left child nodes
      visit_nodes(current_nodes_children[0], graph, visited, ordering)
      # Collect the right child nodes
      visit_nodes(current_nodes_children[1], graph, visited, ordering)
    when POST_ORDER
      # Collect the left child nodes
      visit_nodes(current_nodes_children[0], graph, visited, ordering)
      # Collect the right child nodes
      visit_nodes(current_nodes_children[1], graph, visited, ordering)
      # Collect the current node
      visited << current_node
      else #when IN_ORDER
      # Collect the left child nodes
      visit_nodes(current_nodes_children[0], graph, visited, ordering)
      # Collect the current node
      visited << current_node
      # Collect the right child nodes
      visit_nodes(current_nodes_children[1], graph, visited, ordering)
    end

  end
end
