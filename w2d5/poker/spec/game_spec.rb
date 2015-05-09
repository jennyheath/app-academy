require 'rspec'
require 'game.rb'
require "deck.rb"

describe Game do
  let(:players) { [Player.new("Piggie", 100), Player.new("Kermit", 100), Player.new("Beaker", 100)] }
  let (:bets) { [5, 5, 20, 20, 20, 30] }
  subject(:game) { Game.new }

  before(:each) {
    game.bets = bets
    game.players = players
  }

  describe "#total_bets" do
    it "counts up all the bets" do
      expect(game.total_bets).to eq(100)
    end
  end

  describe "#deal_hand" do
    it "should deal 5 cards" do
      game.deal_hand(players[0])

      expect(players[0].card_count).to eq(5)
    end
  end

  describe "#call?" do
    #return true if bet is equal to current bet
  end

  describe "#raise?" do
    #if true, raise current bet
  end

end
