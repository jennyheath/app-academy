class SlidingPiece < Piece
  def diagonal_moves(pos)
    sliding_moves(pos, DIAG_STEPS)
  end

  def updown_moves(pos)
    sliding_moves(pos, UPDOWN_STEPS)
  end

  def sliding_moves(pos, direction)
    moves = []

    direction.each do |step|
      next_step = [pos[0] + step[0], pos[1] + step[1]]

      until !on_board?(next_step)
        if occupied?(next_step)
          @board[next_step].color != @color ? moves << next_step : break
          break
        end
        moves << next_step
        next_step = [next_step[0] + step[0], next_step[1] + step[1]]
      end
    end

    moves
  end
end
