require 'rspec'
require 'player.rb'

describe Player do
  subject(:player) { Player.new("Steve", 100) }

  describe "#place_bet" do
    it "depletes the player's pot" do
      player.place_bet(10)
      expect(player.pot).to eq(90)
    end
  end

  describe "#fold" do
    it "takes player out of the round" do
      player.fold
      # expect(player.playing).to be_false
      expect(player).to_not be_playing
    end
  end

  describe "#get_winnings" do
    it "increases player's pot" do
      player.get_winnings(40)

      expect(player.pot).to eq(140)
    end
  end

end
