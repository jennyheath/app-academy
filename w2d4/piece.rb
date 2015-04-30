class Piece
  attr_reader :color, :pos
  class InvalidMoveError < StandardError; end
  BLACK_MOVES = [
    [1, 1],
    [1, -1]
  ]
  RED_MOVES = [
    [-1, -1],
    [-1, 1]
  ]

  def initialize(board, color, pos, king_piece=false)
    @board, @color, @pos, @king_piece = board, color, pos, king_piece
  end

  def perform_slide(start_pos, end_pos)
    if valid_move?(start_pos, end_pos)
      move!(start_pos, end_pos)
      @king_piece = true if promote?
    end
  end

  def perform_jump(start_pos, end_pos)
    jumped = jumped_piece(start_pos, end_pos)
    raise InvalidMoveError.new("No one to jump over...") if @board[jumped].nil?
    if valid_jump?(start_pos, end_pos)
      move!(start_pos, end_pos)
      @board[jumped] = nil
      @king_piece = true if promote?
    end
  end

  def jumped_piece(start_pos, end_pos)
    dx = (end_pos.first - start_pos.first) / 2
    dy = (end_pos.last - start_pos.last) / 2
    [start_pos.first + dx, start_pos.last + dy]
  end

  def move_diffs
    if @king_piece
      return RED_MOVES + BLACK_MOVES
    else
      return RED_MOVES if @color == :red
      return BLACK_MOVES if @color == :black
    end
  end

  def jump_move_diffs
    move_diffs + (move_diffs.map { |diff| diff.map {|x| x*2 } })
  end

  def move!(start_pos, end_pos)
    @board[end_pos], @board[start_pos] = self, nil
    @pos = end_pos
  end

  def moves(start_pos)
    moves = move_diffs.map do |coords|
      [coords[0] + start_pos[0], coords[1] + start_pos[1]]
    end

    moves.reject { |move| move.any? { |x| x < 0 || x > 7 } }
  end

  def jump_moves(start_pos)
    moves = jump_move_diffs.map do |coords|
      [coords[0] + start_pos[0], coords[1] + start_pos[1]]
    end

    moves.reject { |move| move.any? { |x| x < 0 || x > 7 } }
  end

  def promote?
    return true if @pos.first == 0 || @pos.first == 7
  end

  def valid_move?(start_pos, end_pos)
    if !@board.empty?(end_pos) || !moves(start_pos).include?(end_pos)
      raise InvalidMoveError.new("Can't move there!")
    else
      true
    end
  end

  def valid_jump?(start_pos, end_pos)
    if !@board.empty?(end_pos) || !jump_moves(start_pos).include?(end_pos)
      raise InvalidMoveError.new("Can't jump there!")
    else
      true
    end
  end
end
