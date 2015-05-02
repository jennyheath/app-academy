require 'rspec'
require 'game.rb'

describe Game do
  let(:players) { [Player.new("Piggie", 100), Player.new("Kermit", 100), Player.new("Beaker", 100)] }
  let (:bets) { [5, 5, 20, 20, 20, 30] }
  subject(:game) { Game.new(Deck.new, players, bets) }

  describe "#total_bets" do
    it "counts up all the bets" do
      expect(total_bets).to eq(100)
    end
  end

  describe "#get_all_hands" do
    #deal hands
    it "returns an array of all the hands of currently playing players" do
      expect(get_all_hands.count).to eq(3)
    end
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
