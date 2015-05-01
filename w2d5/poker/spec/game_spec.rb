require 'rspec'
require 'game.rb'

describe Game do
  let(:players) { [Player.new("Piggie", 100), Player.new("Kermit", 100), Player.new("Beaker", 100)] }
  let (:bets) { [] }
  subject(:game) { Game.new(Deck.new, players, bets) }

  describe "#total_bets" do
    #add bets
    it "counts up all the bets" do
    end
  end

  describe "#get_all_hands" do
    #deal hands
  end

  describe "#best_hand" do
    #uuggghhhhhhh
  end

  describe "#deal_hand" do
    # give 5 cards to player
  end

  describe "#call?" do
    #return true if bet is equal to current bet
  end

  describe "#raise?" do
    #if true, raise current bet
  end

end
