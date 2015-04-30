require_relative 'tic_tac_toe'
# require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator || @board.winner.nil?
        false
      elsif @board.winner != evaluator
        true
      end
    elsif @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    elsif @next_mover_mark != evaluator
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator
        true
      elsif @board.winner != evaluator || @board.winner.nil?
        false
      end
    elsif @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    elsif @next_mover_mark != evaluator
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        if @board.empty?([row_idx, col_idx])
          dup_board = @board.dup
          dup_board[[row_idx, col_idx]] = @next_mover_mark
          child_node = TicTacToeNode.new(dup_board, other_mark(@next_mover_mark), [row_idx, col_idx])
          children << child_node
        end
      end
    end
    children
  end

  def other_mark(mark)
    mark == :x ? :o : :x
  end

end

# empty_board_node = TicTacToeNode.new(Board.new, :x)
# p empty_board_node.children.length
