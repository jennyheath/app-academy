class Knight < SteppingPiece
  KNIGHT_STEPS = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def display
    return "\u2658 " if @color == :white
    return "\u265E " if @color == :black
  end

  def initial_moves
    step_moves(KNIGHT_STEPS)
  end
end
