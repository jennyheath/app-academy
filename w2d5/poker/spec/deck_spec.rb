require 'rspec'
require 'deck.rb'

describe Deck do
  subject(:deck) { Deck.new }

  it "starts with 52 cards" do
    expect(deck.cards.count).to eq(52)
  end

  describe "#take" do
    it "removes the correct amount of cards" do
      deck.take(5)

      expect(deck.cards.count).to eq(47)
    end
  end

  describe "#shuffle!" do
    it "shuffles the deck" do
      # shuffled = deck
      card1 = deck.cards[0]
      deck.shuffle!
      card2 = deck.cards[0]

      expect(card1).to_not eq(card2)
    end
  end

  describe "#return" do
    it "returns cards to the deck" do
      card = deck.cards.shift
      deck.return([card])

      expect(deck.cards.count).to eq(52)
    end
  end
end
