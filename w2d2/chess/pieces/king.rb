class King < SteppingPiece
  def display
    return "\u2654 " if @color == :white
    return "\u265A " if @color == :black
  end

  def initial_moves
    step_moves(UPDOWN_STEPS) + step_moves(DIAG_STEPS)
  end
end
