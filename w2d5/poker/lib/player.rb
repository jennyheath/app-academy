
require_relative "hand"

class Player
  attr_reader :name, :pot
  attr_writer :hand

  def initialize(name, pot)
    @name, @pot = name, pot
    @playing = true
    @hand = nil
  end

  def place_bet(bet)
    @pot -= bet
  end

  def fold
    @playing = false
  end

  def get_winnings(winnings)
    @pot += winnings
  end

  def playing?
    @playing
  end

  def beats?(player2)
    @hand.better_than?(player2.hand)
  end


  def card_count
    @hand.cards.count
  end

  protected

  attr_reader :hand

end
