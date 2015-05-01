require 'rspec'
require 'card.rb'

describe Card do
  subject(:card) { Card.new(:three, :heart) }

  it "has a value" do
    expect(card.value).to eq(:three)
  end

  it "has a suit" do
    expect(card.suit).to eq(:heart)
  end

end
