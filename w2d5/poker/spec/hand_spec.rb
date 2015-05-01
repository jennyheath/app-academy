require 'rspec'
require 'hand.rb'
require_relative 'support/hand_spec_support'

describe Hand do
  subject(:hand) { Hand.new }
  subject(:second_hand) { Hand.new }

  it "has five cards" do
    expect(hand.count).to eq(5)
  end

  context "when analyzing card combinations in a hand" do
    let(:royal_flush) { generate_hand("ah kh qh jh 10h") }
    let(:straight_flush) { generate_hand("8s 7s 6s 5s 4s") }
    let(:four_of_a_kind) {}
    let(:full_house) {}
    let(:flush) {}
    let(:straight) {}
    let(:three_of_a_kind) {}
    let(:two_pair) {}
    let(:one_pair) {}
    let(:bad_hand1) { generate_hand("ad 7h 5s 3d 2s") }
    let(:bad_hand2) { generate_hand("kd 5h 4c 2h 7c") }

    describe "#better_than?" do
      expect(royal_flush.better_than?(straight_flush)).to be(true)
      expect(three_of_a_kind.better_than?(two_pair)).to be(true)
      expect(full_house.better_than?(four_of_a_kind)).to be(false)
      expect(bad_hand2.better_than?(bad_hand1)).to be(false)
    end

    describe "#my_best_hand" do
    end
  end

end
