# frozen_string_literal: true

# A module that wraps the process of performing a breadth first search on a graph of connected nodes.
#
# This algorithm runs in O(V * E)  - polynomial time.
module BreadthFirstSearch

  # Given a start node, goal node and a graph that represents
  # the connections between the nodes in a hash, determine the shortest path between the two
  def self.search(start_node, goal_node, graph)
    # defensive case there is no graph to search through
    return nil if graph.nil?
    # defensive case the graph is empty so no point searching
    return nil if graph.empty?
    # defensive case the graph does not contain the start node
    return nil unless graph.key?(start_node)

    # Create a search queue that starts with the first node's first degree connections
    # It is duplicated so we do not adversely impact the graphs data set.
    search_queue = graph[start_node].dup

    # We need to remember which nodes we have visited
    already_searched = {}

    # We need to remember the path we took via a lookup between each node and its parent
    parents = { start_node: nil }

    # Repeat this process while we have nodes in the queue to be processed, or we have reached our goal.
    while search_queue.any?
      # get the next node from the head of the queue
      current_node = search_queue.shift
      # only process it if it has not already been visited to prevent cyclic infinite revisits of the same node
      unless already_searched.key?(current_node)
        # if we have reached our goal return the path taken
        return reconstitute_path(parents, goal_node) if current_node == goal_node

        if graph.key?(current_node)
          # Store the parent of current_node's neighbours (Its first degree connections)
          neighbours = graph[current_node].dup
          neighbours.each { |neighbour| parents[neighbour] = current_node }
          # Add the current_node's neighbours to the queue to be processed
          search_queue.concat(neighbours)
        end

        # Remember the name of the node that we have checked
        already_searched[current_node] = true
      end
    end

    # The goal_node was not located in the graph
    nil
  end

  def self.path_exists?(start_node, goal_node, graph)
    !search(start_node, goal_node, graph).nil?
  end

  # Determines the path taken to reach the goal by working back from the goal_node to the start_node via the parents
  private_class_method def self.reconstitute_path(parents, goal_node)
    path_taken = []
    current = goal_node
    while current
      # add the node at the start of the array
      path_taken.unshift(current)
      current = parents[current]
    end
    path_taken
  end

end
