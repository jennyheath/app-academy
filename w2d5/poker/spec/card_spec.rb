require 'rspec'
require 'card.rb'

describe Card do
  subject(:card) { Card.new(3, :heart) }

  it "has a value" do
    expect(card.value).to eq(3)
  end

  it "has a suit" do
    expect(card.suit).to eq(:heart)
  end

  it "rejects invalid card"
    # expect { Card.new(:three, :octagon) }.to raise_error(BadCardError)
  # end
end
