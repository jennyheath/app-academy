require_relative 'board'


class Game
  attr_reader :board, :curr_player

  def initialize(player1=nil, player2=nil)
    @board = CheckerBoard.new
    @winner = nil
    @player1 = player1 || HumanPlayer.new(self, :red)
    @player2 = player2 || HumanPlayer.new(self, :black)
    @curr_player = @player1
  end

  def play
    @board.set_board
    puts "CH-CH-CH-CHECKERSSSSS"
    puts
    @board.display

    until won?
      puts "#{@curr_player.color.to_s.capitalize}\'s turn"
      @curr_player.play_turn
      switch_player
    end

    puts "#{@winner.to_s.capitalize} is the winner!"
  end

  def switch_player
    @curr_player = (@curr_player == @player1) ? @player2 : @player1
  end

  def won?
    pieces = []
    @board.each_tile_with_index do |row, row_idx, tile, col_idx|
      pieces << tile if tile
    end

    if pieces.none? { |piece| piece.color == :red }
      @winner = :black
      return true
    elsif pieces.none? { |piece| piece.color == :black }
      @winner = :red
      return true
    else
      false
    end
  end

  def winner
    @winner
  end

end

class HumanPlayer
  attr_reader :color

  def initialize(game, color)
    @game = game
    @color = color
  end

  def play_turn
    begin
      print "What piece would you like to move? Enter coordinates (i.e. 1,2): "
      start_pos = gets.chomp.split(",").reverse.map { |i| i.to_i - 1 }
      print "Where would you like to move? If making multiple jumps,
      separate each set of coordinates with a space,
      i.e. \"4,4 6,6 4,8\". Enter coordinates: "
      moves = gets.chomp.split(" ").map { |move| move.split(",").reverse }
      end_pos = moves.map { |move| move.map { |i| i.to_i - 1 } }
      piece = @game.board[start_pos]

      if piece && piece.color == @color
        @game.board[start_pos].perform_moves([start_pos] + end_pos)
      else
        raise InvalidMoveError.new("Nope.")
      end
    rescue InvalidMoveError => e
      puts e
      retry
    rescue ArgumentError
      puts "Invalid input"
    end

    @game.board.display
  end
end
