require 'rspec'
require 'towers.rb'


describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }

  it "has 3 towers" do
    expect(game.towers).to be_an(Array)
    expect(game.towers.length).to eq(3)
  end

  it "has 3 discs on tower 1" do
    expect(game.towers[0]).to eq([3, 2, 1])
  end

  describe "#move" do
    it "moves a disc from one tower to another" do
      game.move(0, 1)
      expect(game.towers[0]).to eq([3, 2])
      expect(game.towers[1]).to eq([1])
    end

    it "does not move from an empty tower" do
      expect { game.move(2, 0) }.to raise_error(InvalidMoveError)
    end

    it "does not move a bigger disc onto a smaller disc" do
      game.move(0, 1)

      expect { game.move(0, 1) }.to raise_error(InvalidMoveError)
    end
  end

  describe "#won?" do
    it "determines when the game is won" do
      game.move(0, 1)
      game.move(0, 2)
      game.move(1, 2)
      game.move(0, 1)
      game.move(2, 0)
      game.move(2, 1)
      game.move(0, 1)

      expect(game.won?).to be(true)
    end

    it "only finds a win when the discs are not on the original tower" do
      expect(game.won?).to be(false)
    end
  end

end
