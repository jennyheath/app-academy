class Piece

  class InvalidMoveError
  end
  def initialize(color, pos, king_piece=false)
    @color = color
    @pos = pos
    @king_piece = king_piece
  end

  def perform_slide(start_pos, end_pos)
    raise InvalidMoveError if !empty?(end_pos)


  end

  def perform_jump
  end

  def empty?(pos)
  end

  def move_diffs
  end

  def promote?
  end
end
