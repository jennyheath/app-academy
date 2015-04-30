require_relative './00_tree_node.rb'
# require 'byebug'


class KnightPathFinder

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end

  def self.valid_moves(pos)
    possible_moves = []
    INCREMENT_MOVES.each do |increment|
      move = [increment[0] + pos.value[0], increment[1] + pos.value[1]]
      possible_moves << move if on_board?(move)
    end
    possible_moves
  end

  INCREMENT_MOVES = [[2, 1],
                     [2, -1],
                     [-2, 1],
                     [-2, -1],
                     [1, 2],
                     [1, -2],
                     [-1, 2],
                     [-1, -2]]

  def self.on_board?(pos)
    pos.all? { |n| n >= 0 && n < 8 }
  end

  def new_move_positions(pos)
    possible_moves = self.class.valid_moves(pos)
    possible_moves.reject { |move| @visited_positions.include?(move) }
  end

  def build_move_tree
    root_node = PolyTreeNode.new(@start_pos)
    queue = [root_node]
    until queue.empty?
      current_node = queue.shift
      children = new_move_positions(current_node)
      @visited_positions += children
      child_nodes = children.map do |value|
        child_node = PolyTreeNode.new(value)
        child_node.parent = current_node
        queue.push(child_node)
      end
    end
    root_node
  end

  def find_path(end_pos)
    build_move_tree.dfs(end_pos).trace_path_back.reverse
  end
end

knight = KnightPathFinder.new([0, 0])
# p knight.find_path([5, 5])
# p knight.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
# p knight.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
