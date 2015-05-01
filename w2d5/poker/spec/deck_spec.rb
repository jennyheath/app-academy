require 'rspec'
require 'deck.rb'

describe Deck do
  subject(:deck) { Deck.new }

  it "starts with 52 cards" do
    expect(deck.cards.count).to eq(52)
  end

  describe "#take" do
    deck.take(5)
    expect(deck.cards.count).to eq(47)
  end

  describe "#shuffle!" do
    shuffled = deck
    deck.shuffle!
    expect(deck).to_not eq(shuffled)
  end

  describe "#return" do
    card = deck.cards.shift
    deck.return(card)

    expect(deck.cards.count).to eq(52)
  end

  end
end
