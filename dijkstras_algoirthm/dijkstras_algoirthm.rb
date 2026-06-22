# frozen_string_literal: true

# An algorithm to define the most efficient cost/distance from two nodes in a weighted graph.
# See also https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#:~:text=Assign%20to%20every%20node%20a,is%20known%20to%20these%20nodes.
# Note only works for positive weighted graphs.
# For weighted graphs that include negatives you need to use Bellman-Ford algorithm instead.
module DijkstrasAlgoirthm

  # A simple class to wrap the cost/distance and the path taken
  class Result
    attr_reader :cost, :path_taken

    def initialize(cost, path_taken)
      @cost = cost
      @path_taken = path_taken
    end

  end

  EMPTY_RESULT = Result.new(nil,nil).freeze

  def self.find_most_efficient_path(graph, start_node, goal_node)
    # Defensive - return empty result for nil or empty graph
    return EMPTY_RESULT if graph.nil? || graph.empty?

    # Defensive - return empty result for graph that does not contain the start and end nodes
    unless graph.key?(start_node) && graph.key?(goal_node)
      raise ArgumentError, 'Graph must contain both start and goal nodes'
    end

    # determine the current cost/distance to reach each node from (excluding the start node)
    # The start node has zero cost/distance, everything else has Infinity cost/distance before the algorithm runs
    costs = generate_initial_costs(graph, start_node)

    # Remember the parents of each node as they get processed
    parents = {}

    # Remember which nodes we have already processed
    processed_nodes = Set.new

    # The first time we call this it will return the start node since we set it to have 0 cost
    current_node = lowest_cost_node(costs, processed_nodes)
    while current_node
      # get the current nodes cost
      cost = costs[current_node]
      # get the current nodes neighbours (out neighbours)
      neighbours = graph[current_node]

      neighbours.each do |neighbour_node, neighbour_cost|
        # calculate a new potential cost for travelling from the current_node to the neighbour node
        new_cost = cost + neighbour_cost
        if costs[neighbour_node] > new_cost
          # if the cost is lower than we had for this neighbour node - the new cost becomes the calculated cost
          # i.e. current best route is via the current node
          costs[neighbour_node] = new_cost
          parents[neighbour_node] = current_node
        end
      end
      # add the current node to the set of nodes already processed
      processed_nodes << current_node

      # get the next node to be processed or nil if we have processed them all
      current_node = lowest_cost_node(costs, processed_nodes)
    end
    # wrap the result w.r.t. cost/distance and path taken
    Result.new(costs[goal_node], reconstitute_path_taken(parents, goal_node))
  end

  def self.generate_initial_costs(graph, start_node)
    costs = {}
    # set the start node to 0 cost/distance and everything else to infinity
    graph.each_key { |key| costs[key] = (key == start_node ? 0 : Float::INFINITY) }
    costs
  end

  def self.lowest_cost_node(costs, processed_nodes)
    lowest_cost = Float::INFINITY
    lowest_node = nil
    costs.each do |node_name, cost|
      # find the node with the lowest cost that has not already been processed
      if cost < lowest_cost && !processed_nodes.include?(node_name)
        lowest_node = node_name
        lowest_cost = cost
      end
    end
    # When we have processed all nodes this will be nil
    lowest_node
  end

  def self.reconstitute_path_taken(parents, goal_node)
    # Add the goal_node to the end of the path taken
    path_taken = [goal_node]

    # find the parent of the goal_node
    parent_node = parents[goal_node]
    while parent_node
      # add this parent to the start of the path taken
      path_taken.unshift(parent_node)
      # find its parent
      parent_node = parents[parent_node]
    end
    path_taken
  end

end
