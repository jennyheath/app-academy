class Bishop < SlidingPiece
  def display
    return "\u2657 " if @color == :white
    return "\u265D " if @color == :black
  end

  def initial_moves
    diagonal_moves(@pos)
  end
end
