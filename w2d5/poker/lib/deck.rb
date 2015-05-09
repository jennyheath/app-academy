require_relative "card.rb"

class Deck
  attr_reader :cards

  def initialize
    @cards = generate_cards
  end

  def generate_cards
    deck = []

    Card.values.each do |value|
      Card.suits.each do |suit|
        deck << Card.new(value, suit)
      end
    end

    deck
  end

  def shuffle!
    @cards = @cards.shuffle
  end

  def take(n)
    @cards.shift(n)
  end

  def return(cards)
    cards.each { |card| @cards << card }
  end
end
