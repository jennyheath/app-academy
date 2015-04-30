class Rook < SlidingPiece
  def display
    return "\u2656 " if @color == :white
    return "\u265C " if @color == :black
  end

  def initial_moves
    updown_moves(@pos)
  end
end
