require_relative 'board'

class Game
  attr_accessor :board
  attr_reader :player1, :player2, :current_player

  def initialize(player1=nil, player2=nil)
    @player1 = player1 || HumanPlayer.new(:white)
    @player2 = player2 || HumanPlayer.new(:black)
    @board = ChessBoard.new
    @curr_player = @player1
  end

  def play
    @board.set_board
    @board.display
    until over?
      begin
        play_current_players_turn
      rescue InvalidMoveError => e
        puts e.message
        retry
      end
    end
    puts "#{winner.capitalize} wins!"
  end

  private

  def play_current_players_turn
    start_pos, end_pos = @curr_player.play_turn
    assert_correct_player(@curr_player, start_pos)

    @board.move(start_pos, end_pos)
    switch_player
    @board.display
  end

  def switch_player
    @curr_player == player1 ? @curr_player = player2 : @curr_player = player1
  end

  def over?
    @board.checkmate?(:black) || @board.checkmate?(:white)
  end

  def winner
    @board.checkmate?(:black) == true ? :white : :black
  end

  def assert_correct_player(curr_player, start_pos)
    if @board[start_pos].color != curr_player.color
      raise InvalidMoveError.new("That is not your piece.")
    end
  end

end

class HumanPlayer
  LETTER_COORDS = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7
  }
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    begin
      puts "It\'s #{@color}\'s turn"
      coords = prompt_and_parse
      start_pos, end_pos = coords[0], coords[1]
      [start_pos, end_pos]
    rescue InvalidMoveError => e
      puts e.message
      retry
    end
  end

  def letter_coords
    LETTER_COORDS
  end

  def prompt_and_parse
    puts "Where do you want to move? (i.e. f2,f3)"
    coords = gets.chomp.split(",")
    new_coords = coords.map do |coord|
      letter = coord[0]
      number = coord[1].to_i
      [number - 1, letter_coords[letter]]
    end

    new_coords
  end
end

game = Game.new
game.play
