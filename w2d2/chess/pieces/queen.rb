class Queen < SlidingPiece
  def display
    return "\u2655 " if @color == :white
    return "\u265B " if @color == :black
  end

  def initial_moves
    updown_moves(@pos) + diagonal_moves(@pos)
  end
end
