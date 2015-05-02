require 'rspec'
require 'hand.rb'
require_relative 'support/hand_spec_support'

describe Hand do
  subject(:hand) { generate_hand("5d 5s 5h 4c 3h") }
  subject(:second_hand) { generate_hand("kd 5h 4c 2h 7c") }

  it "has five cards" do
    expect(hand.count).to eq(5)
  end

  context "when analyzing card combinations in a hand" do
    let(:royal_flush) { generate_hand("ah kh qh jh 10h") }
    let(:straight_flush) { generate_hand("8s 7s 6s 5s 4s") }
    let(:four_kind) { generate_hand("5d 5s 5h 5c 3h") }
    let(:four_kind2) { generate_hand("6d 6s 6h 6c 3d") }
    let(:full_house) { generate_hand("kh kd ks 5h 5c") }
    let(:flush) { generate_hand("ks js 9s 7s 3s") }
    let(:straight) { generate_hand("qs jd 10c 9s 8h") }
    let(:three_kind) { generate_hand("5d 5s 5h 4c 3h") }
    let(:two_pair) { generate_hand("kh ks jc jd 9d") }
    let(:one_pair) { generate_hand("as ad 9h 6s 4d") }
    let(:one_pair2) { generate_hand("ah ac 9c 5d 4c") }
    let(:bad_hand1) { generate_hand("ad 7h 5s 3d 2s") }
    let(:bad_hand2) { generate_hand("kd 5h 4c 2h 7c") }

    describe "#better_than?" do
      it "compares hands" do
        expect(royal_flush.better_than?(straight_flush)).to be(true)
        expect(three_kind.better_than?(two_pair)).to be(true)
        expect(full_house.better_than?(four_kind)).to be(false)
        expect(bad_hand2.better_than?(bad_hand1)).to be(false)
      end
    end

    describe "#my_best_hand" do
      it "finds the best category" do
        expect(bad_hand1.my_best_hand).to eq(high_card)
        expect(full_house.my_best_hand).to eq(full_house)
      end
    end
  end

  describe "#tie_breaker" do

    it "finds the higher hand from two of the same category" do
      expect(tie_breaker(four_kind, four_kind2)).to eq(four_kind2)
      expect(tie_breaker(one_pair, one_pair2)).to eq(one_pair)
    end

end
