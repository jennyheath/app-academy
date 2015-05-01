class InvalidMoveError < StandardError; end
class Piece
  attr_reader :board, :color, :pos, :king, :symbol
  BLACK_MOVES = [[1, 1],   [1, -1]]
  RED_MOVES =   [[-1, -1], [-1, 1]]

  def initialize(board, color, pos, king = false)
    @board, @color, @pos, @king = board, color, pos, king
    @symbol = @king ? "\u265A" : "\u25CB"
  end

  def perform_slide(start_pos, end_pos)
    if valid_slide?(start_pos, end_pos)
      move!(start_pos, end_pos)
      @king = true if promote?
      true
    else
      false
    end
  end

  def perform_jump(start_pos, end_pos)
    if valid_jump?(start_pos, end_pos)
      move!(start_pos, end_pos)
      @board[jumped_piece(start_pos, end_pos)] = nil
      @king = true if promote?
      true
    else
      false
    end
  end

  def perform_moves(move_sequence)
    if move_sequence.count == 2
      start_pos, end_pos = move_sequence
      unless perform_slide(start_pos, end_pos) || perform_jump(start_pos, end_pos)
        raise InvalidMoveError.new("Can't move there.")
      end

      perform_slide(start_pos, end_pos) if valid_slide?(start_pos, end_pos)
      perform_jump(start_pos, end_pos) if valid_jump?(start_pos, end_pos)
    elsif valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError.new("Invalid move sequence")
    end
  end

  def move!(start_pos, end_pos)
    @board[end_pos] = self
    @board[start_pos] = nil
    @pos = end_pos
  end

  def perform_moves!(move_sequence)
    start_pos, *moves = move_sequence
    moves.each do |move|
      self.board[start_pos].perform_jump(start_pos, move)
      start_pos = move
    end
  end

  def slide_moves(start_pos)
    x, y = start_pos
    moves = slide_move_diffs.map { |(dx, dy)| [x + dx, y + dy] }
    moves.reject { |move| move.any? { |i| i < 0 || i > 7 } }
  end

  def jump_moves(start_pos)
    x, y = start_pos
    moves = jump_move_diffs.map { |(dx, dy)| [x + dx, y + dy] }
    moves.reject { |move| move.any? { |i| i < 0 || i > 7 } }
  end

  def slide_move_diffs
    return RED_MOVES + BLACK_MOVES if @king
    return RED_MOVES   if @color == :red
    return BLACK_MOVES if @color == :black
  end

  def jump_move_diffs
    slide_move_diffs.map { |diff| diff.map {|i| i * 2 } }
  end

  def jumped_piece(start_pos, end_pos)
    x = (end_pos.first + start_pos.first) / 2
    y = (end_pos.last + start_pos.last) / 2
    [x, y]
  end

  def promote?
    if @pos.first == 0 || @pos.first == 7
      @symbol = "\u265A"
      return true
    end

    return false
  end

  def valid_slide?(start_pos, end_pos)
    !@board[end_pos] && slide_moves(start_pos).include?(end_pos)
  end

  def valid_jump?(start_pos, end_pos)
    jumped = jumped_piece(start_pos, end_pos)
    return false unless @board[jumped]
    jumped_opponent = true if @board[jumped].color != @color

    !@board[end_pos] && jump_moves(start_pos).include?(end_pos) && jumped_opponent
  end

  def valid_move_seq?(move_sequence)
    test_board = @board.dup_board
    test_piece = test_board[@pos]
    begin
      test_piece.perform_moves!(move_sequence)
      return true
    rescue InvalidMoveError => e
      puts e
    end

    return false
  end
end
