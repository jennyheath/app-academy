require_relative "player"

class Game
  attr_accessor :bets, :players

  def initialize
    @deck = Deck.new
    @bets = []
    @current_bet = 0
    @players = []
  end


  def play


    until game_over?
      get_bets
    end
  end







  def deal_hand(player)
    player.hand = Hand.new(@deck.take(5))
  end

  def total_bets
    @bets.inject(:+)
  end

  def game_over?
    @players.select { |player| player.playing? }.length == 1
  end
end
