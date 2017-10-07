require "byebug"
require_relative "00_tree_node.rb"

class KnightPathFinder
  attr_accessor :grid, :created_positions
  attr_reader :start_pos

  MOVE_COORDINATES = [[1,-2],[2,-1],[1,2],[2,1],
  [-1,-2],[-2,-1],[-1,2],[-2,1]]


  def initialize(start_pos = [0,0])
    @start_pos = start_pos
    @grid = grid
    @created_positions = [start_pos]
    @move_tree = build_move_tree
  end

  def self.valid_moves(pos)
    moves = []
    MOVE_COORDINATES.each do |coords|
      actual_move = [coords[0] + pos[0], coords[1] + pos[1]]
      moves << actual_move if KnightPathFinder.valid_pos?(actual_move)
    end
    moves
  end

  def self.valid_pos?(pos)
    pos.all? { |n| n.between?(0, 7) }
  end

  def build_move_tree
    root = PolyTreeNode.new(start_pos)
    queue = [root]
    tree = [root]

    until queue.empty?
      positions = new_move_positions(queue.first.value)
      nodes = positions.map { |pos| PolyTreeNode.new(pos) }
      nodes.each do |node|
        queue.first.add_child(node)
        tree << node
      end

      queue.shift

      queue +=  nodes
    end

    tree
  end

  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos).reject do |move|
      created_positions.include?(move)
    end
    created_positions.concat(new_positions)

    new_positions
  end

  def find_path(end_pos)
    dfs(end_pos)
  end

  def trace_path_back(node)
    path = [node.value]

    while path.first.parent
    current_node = path.first
    path.unshift(current_node.parent)
    end
    path.map(&:value)
  end


  def interface
  end


end


knight = KnightPathFinder.new()
node = knight.find_path([5,5])
trace_path_back(node)
