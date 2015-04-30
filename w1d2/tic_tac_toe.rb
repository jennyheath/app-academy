class Board

  def initialize
    @board = Array.new(3) { Array.new(3) }
  end

  def won?

  end

  def winner
  end

  def empty?(pos) #pos == [y-coord, x-coord]
    row = pos[1]
    col = pos[0]
    if @board[col][row]
      false
    else
      true
    end
  end

  def place_mark(pos, mark)


  end

end

class Mark
  def intitialize(col, row)
    @pos = [col, row]
  end
end

class Game
  attr_reader :human_player, :computer_player, :board

  def initialize
    @human_player = HumanPlayer.new
    @computer_player = ComputerPlayer.new
    @board = Board.new
  end

  def play

    until won?

  end

end

class HumanPlayer

  def intialize
    @mark_list = []
  end

  def turn
    @board.place_mark
  end

end

class ComputerPlayer

  def intialize
    @mark_list = []
  end

  def turn

  end

  def winning_move
  end

end
