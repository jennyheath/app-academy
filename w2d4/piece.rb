require_relative 'board'

class Piece
  class InvalidMoveError
  end
  RED_MOVES = [
    [1, 1],
    [1, -1],
    # [2, 2],
    # [2, -2]
  ]
  BLACK_MOVES = [
    [-1, -1],
    [-1, 1],
    # [-2, -2],
    # [-2, 2]
  ]

  def initialize(board, color, pos, king_piece=false)
    @board = board
    @color = color
    @pos = pos
    @king_piece = king_piece
  end

  def perform_slide(start_pos, end_pos)
    if valid_move?(end_pos)
      move!(start_pos, end_pos)
      @king_piece = true if promote?
    end
  end

  def perform_jump(start_pos, end_pos)
    raise InvalidMoveError.new("No one to jump over...") if @board[jumped_piece].nil?
    if valid_jump?(end_pos)
      move!(start_pos, end_pos)
      @board[jumped_piece] = nil
      @king_piece = true if promote?
  end

  def empty?(pos)
    @board[pos].nil?
  end

  def jumped_piece(start_pos, end_pos)
    dx = (end_pos.first - start_pos.first) / 2
    dy = (end_pos.first - start_pos.first) / 2
    [start_pos.first + dx, start_pos.first + dy]
  end

  def move_diffs
    if @color == :red
      return RED_MOVES if !@king_piece
      return BlACK_MOVES if @king_piece
    elsif @color == :black
      return BlACK_MOVES if !@king_piece
      return RED_MOVES if @king_piece
    end
  end

  def jump_move_diffs
    move_diffs + (move_diffs.map { |diff| diff.map {|x| x*2 } })
  end

  def move!
    @board[end_pos], @board[start_pos] = self, nil
    @pos = end_pos
  end

  def promote?
    return true if @pos.first == 0 || @pos.first == 7
  end

  def valid_move?(pos)
    if !empty?(pos) || !move_diffs.include?(pos)
      raise InvalidMoveError.new("Can't move there!")
    else
      true
    end
  end

  def valid_jump?(pos)
    if !empty?(pos) || !jump_move_diffs.include?(pos)
      raise InvalidMoveError.new("Can't jump there!")
    else
      true
    end
  end
end
