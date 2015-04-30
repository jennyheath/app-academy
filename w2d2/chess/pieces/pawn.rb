class Pawn < Piece
  PAWN_STEPS_BLACK = [[1, 0], [2, 0]]
  PAWN_STEPS_WHITE = [[-1, 0], [-2, 0]]
  PAWN_STEPS_BLACK_DIAG = [[1, 1], [1, -1]]
  PAWN_STEPS_WHITE_DIAG = [[-1, 1], [-1, -1]]

  def display
    return "\u2659 " if @color == :white
    return "\u265F " if @color == :black
  end

  def forward_moves
    if @moved == false
      return pawn_moves(PAWN_STEPS_BLACK) if @color == :black
      return pawn_moves(PAWN_STEPS_WHITE) if @color == :white
    else
      return pawn_moves([PAWN_STEPS_BLACK.first]) if @color == :black
      return pawn_moves([PAWN_STEPS_WHITE.first]) if @color == :white
    end
  end

  def diag_moves
    steps = PAWN_STEPS_BLACK_DIAG if @color == :black
    steps = PAWN_STEPS_WHITE_DIAG if @color == :white
    moves = []

    steps.each do |step|
      next_step = [pos[0] + step[0], pos[1] + step[1]]
      if on_board?(next_step) && occupied?(next_step)
        moves << next_step if @board[next_step].color != @color
      end
    end

    moves
  end

  def initial_moves
    forward_moves + diag_moves
  end

  def pawn_moves(steps)
    moves = []
    steps.each do |step|
      next_step = [pos[0] + step[0], pos[1] + step[1]]
      moves << next_step if on_board?(next_step) && !occupied?(next_step)
    end

    moves
  end
end
