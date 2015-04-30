require 'byebug'

class Piece
  attr_reader :color
  attr_accessor :pos, :moved

  DIAG_STEPS = [[-1,1], [1,1], [-1,-1], [1,-1]]
  UPDOWN_STEPS = [[0,1], [0,-1], [1,0], [-1,0]]

  def initialize(board, color, pos, moved = false)
    @board = board
    @color = color
    @pos = pos
    @moved = moved
  end

  def moves
    raise NotImplementedError
  end

  def valid_moves
    initial_moves.reject { |pos| move_into_check?(pos) }
  end

  def move_into_check?(pos)
    board_dup = @board.deep_dup
    board_dup.move!(@pos, pos)
    board_dup.in_check?(@color)
  end

  def occupied?(pos)
    !@board[pos].nil?
  end

  def on_board?(pos)
    pos.none? { |coord| coord < 0 || coord > 7 }
  end
end
